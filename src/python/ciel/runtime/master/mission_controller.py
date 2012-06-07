# Copyright (c) 2012 Zubair Nabi <zubair.nabi@cl.cam.ac.uk>
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

import threading
import sys
import ciel
import logging

class MissionController:

    def __init__(self, bus, job_pool):
        self.job_pool = job_pool
        self.bus = bus
        self.is_running = False
        self.thread = None
        
    def get_all_job_ids(self):
        return self.job_pool.jobs.keys()
    
    def print_all(self):
        for job in self.job_pool.jobs.itervalues():
            ciel.log("Job ID: %s" % job.id, "MissionController", logging.INFO)
            for task in job.task_graph.tasks.itervalues():
                ciel.log("Task ID: %s" % task.task_id, "MissionController", logging.INFO)
                print "Inputs"
                for task_input in task.inputs.itervalues():
                    print task_input.id
                print "Dependencies"
                for dependency in task.dependencies.itervalues():
                    print dependency.id
                print "Outputs"
                for output in task.expected_outputs:
                    print output 
    
            #for ref_entry in job.task_graph.references.itervalues():
                #ciel.log("Reference ID: %s" % ref_entry.ref.id, "MissionController", logging.INFO)
                
    def subscribe(self):
        self.bus.subscribe("start", self.start)

    def unsubscribe(self):
        self.bus.unsubscribe("stop", self.stop)
        
    def start(self):
        self.is_running = True
        self.thread = threading.Thread(target=self.thread_loop)
        self.thread.start()
              
    def stop(self):
        self.is_running = False
        
    def thread_loop(self):
        while self.is_running:
            self.print_all()
            threading.Event().wait(10)
        
def main(my_args):
    mission_controller = MissionController()
    mission_controller.print_all()
     
if __name__ == '__main__':
    main(sys.argv[1:])   