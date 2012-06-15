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

class ThrottleController:

    def __init__(self, bus, process_pool):
        self.process_pool = process_pool
        self.bus = bus
        self.is_running = False
        self.thread = None

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
            threading.Event().wait(1)
 