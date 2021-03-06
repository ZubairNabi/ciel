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
import collections

class MissionController:

    def __init__(self, bus, job_pool, policy):
        self.job_pool = job_pool
        self.bus = bus
        self.is_running = False
        self.thread = None
        self.policy = policy
        self.init_isis2('/root/ciel/lib/Isis.dll')
        
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
        self.is_running = False
        self.thread = threading.Thread(target=self.thread_loop)
        self.thread.start()
              
    def stop(self):
        self.is_running = False
        
    def thread_loop(self):
        while self.is_running:
            #self.print_all()
            self.policy.update_weights(self.job_pool)
            self.mark_stage_type()
            threading.Event().wait(1)
    
    def set_policy(self, policy):
        self.policy = policy
        
    def mark_stage_type(self):
        for job in self.job_pool.jobs.itervalues():
            ciel.log("Job ID: %s" % job.id, "MissionController", logging.INFO)
            task_queue = collections.deque()
            
            for task in job.task_graph.tasks.itervalues():
                task_queue.append(task)
                
            while len(task_queue) > 0:
                task = task_queue.popleft()
                
                for local_id, ref in task.dependencies.items():
                    pass
                
    def init_isis2(self, isis2_lib_path):
        import clr
        clr.AddReferenceToFileAndPath(isis2_lib_path)
        import Isis
        from Isis import *
        IsisSystem.Start()
            
class MissionControllerPolicy:

    def __init__(self, policy_type):
        self.policy_type = policy_type
    
    def update_weights(self, job_pool):
        pass

class FIFOPolicy(MissionControllerPolicy):
    
    def __init__(self, policy_type):
        MissionControllerPolicy.__init__(self, policy_type)
    
    def update_weights(self, job_pool):
        jobs_time = {}
        total_num_jobs = len(job_pool.jobs)

        for job in self.job_pool.jobs.itervalues():
            time, description = job.history[0]
            jobs_time[time] = job.id
        
        total_sum = 0
        for i in range(total_num_jobs):
            total_sum = total_sum + i

        times = jobs_time.items()
        times.sort()
        count = total_num_jobs
        for k, v in times:
            job_pool.jobs[v].mc_weight = (count/sum)
            count = count - 1
            
class PerformancePolicy(MissionControllerPolicy):
    
    def __init__(self, policy_type):
        MissionControllerPolicy.__init__(self, policy_type)
    
    def update_weights(self, job_pool):  
        for job in self.job_pool.jobs.itervalues(): 
            pass
    
class PriorityPolicy(MissionControllerPolicy):
    
    def __init__(self, policy_type):
        MissionControllerPolicy.__init__(self, policy_type)
        self.jobs_priority = {}
    
    def update_weights(self, job_pool):   
        pass

class FairPolicy(MissionControllerPolicy):
    
    def __init__(self, policy_type):
        MissionControllerPolicy.__init__(self, policy_type)
    
    def update_weights(self, job_pool):   
        total_num_jobs = len(job_pool.jobs)
        equal_share = 1/total_num_jobs

        for job in self.job_pool.jobs.itervalues():
            job.mc_weight = equal_share
    
class FlightController:
    
    def __init__(self):
        self.protocol = 'TCP'
        self.num_transfers = 5
        self.protocol_parameters = []
    
    def set_protocol(self, protocol):
        self.protocol = protocol
        
    def set_num_transfer(self, num_transfers):
        self.num_transfers = num_transfers
        
def main(my_args):
    mission_controller = MissionController()
    mission_controller.print_all()
     
if __name__ == '__main__':
    main(sys.argv[1:])   