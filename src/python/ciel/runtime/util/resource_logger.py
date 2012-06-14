# Copyright (c) 2012 Zubair Nabi <Zubair.Nabi@cl.cam.ac.uk>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

import csv
import os
import threading
import datetime
import sys
import subprocess

class ResourceUsageLogger:
    
    def __init__(self, log_file_path, log_id):
        log_file_name = 'resources.csv'
        tcp_log_file_name = 'tcp.csv'
        resource_dir = os.path.join(log_file_path, log_id)
        try:
            os.mkdir(resource_dir)
        except:
            resource_dir = log_file_path
        self.log_file = os.path.join(resource_dir, log_file_name)
        self.csv_writer = csv.writer(open(self.log_file, 'wba'), delimiter =',',
                                     quotechar='|', quoting = csv.QUOTE_MINIMAL) 
        self.tcp_log_file = os.path.join(resource_dir, tcp_log_file_name)
        self.tcp_csv_writer = csv.writer(open(self.tcp_log_file, 'wba'), delimiter =',',
                                     quotechar='|', quoting = csv.QUOTE_MINIMAL) 
        self.previous_stats = self.get_current_stats()
        self.write_first_row()
        
    def write_first_row(self):
        csv_row = []   
        
        csv_row.append('timestamp')
                        
        for intf in self.get_interface_names():
            csv_row.append(intf + ':bytes_sent')
            csv_row.append(intf + ':bytes_recv') 
        
        csv_row.extend(self.get_cpu_names())
            
        self.csv_writer.writerow(csv_row)

    def get_current_stats(self):
        csv_row = []
        csv_row.append(datetime.datetime.now())
        csv_row.append(self.get_cpu_usage())
        csv_row.extend(self.get_network_io())
        return csv_row
    
    def write_current_stats(self):
        current_stats = self.get_current_stats()
        csv_row = []
        
        csv_row.append(current_stats[0])
        
        for i in range(2, len(current_stats)):
            csv_row.append(int(current_stats[i]) - int(self.previous_stats[i]))
        for k in sorted(current_stats[1]):
            current_usage = 0.0
            previous_usage = 0.0
            current_total = 0.0
            previous_total = 0.0
            
            for j in range(3):                               
                current_usage += current_stats[1][k][j] 
                previous_usage += self.previous_stats[1][k][j] 
            
            for j in range(7):                               
                current_total += current_stats[1][k][j] 
                previous_total += self.previous_stats[1][k][j] 

            diff_total = current_total - previous_total
            diff_usage = current_usage - previous_usage
            if diff_total == 0:
                usage = 0
            else:
                usage = (diff_usage / diff_total) * 100
            csv_row.append(usage)
            
        self.csv_writer.writerow(csv_row)
        self.previous_stats = current_stats
        
    def thread_loop(self):
        while True:
            try:
                self.write_current_stats()
                self.write_tcp_data()
                threading.Event().wait(1)
            except KeyboardInterrupt:
                return
        
    def get_network_io(self): 
        list_network_io = []
        with open('/proc/net/dev', 'r') as f:
            next(f)
            next(f)
            for intf in f:
                intf_data = intf.split()
                list_network_io.append(intf_data[1])
                list_network_io.append(intf_data[9])
        return list_network_io
            
    def get_interface_names(self): 
        list_interfaces = []
        with open('/proc/net/dev', 'r') as f:
            next(f)
            next(f)
            for intf in f:
                intf_data = intf.split()
                list_interfaces.append(intf_data[0])
        return list_interfaces
    
    def get_cpu_names(self): 
        list_cpus = []
        with open('/proc/stat', 'r') as f:
            next(f)
            for cpu in f:
                cpu_data = cpu.split()
                if cpu_data[0].startswith('cpu'):
                    list_cpus.append(cpu_data[0])
        return list_cpus
    
    def get_cpu_usage(self):
        dict_cpus = {}
        with open('/proc/stat', 'r') as f:
            next(f)
            for cpu in f:
                cpu_data = cpu.split()
                if cpu_data[0].startswith('cpu'):
                    cpu_name = cpu_data[0]
                    del cpu_data[0]
                    dict_cpus[cpu_name] = map(int, cpu_data)                
        return dict_cpus
    
    def get_tcp_q_size(self):
        list_tcp_data = []
        process = subprocess.Popen('netstat --inet -n', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        lines = process.stdout.readlines()
        del lines[0]
        del lines[0]
        for line in lines:
            line_data = line.split()
            list_tcp_data.append(line_data[1])
        retval = process.wait()
        return list_tcp_data
    
    def write_tcp_data(self):
        current_tcp_data = self.get_tcp_q_size()
        current_tcp_data.insert(0, datetime.datetime.now())
        self.tcp_csv_writer.writerow(current_tcp_data)
     

def main(my_args):
    resource_usage_logger = ResourceUsageLogger(my_args[0], my_args[1])
    resource_usage_logger.thread_loop()

     
if __name__ == '__main__':
    main(sys.argv[1:])    