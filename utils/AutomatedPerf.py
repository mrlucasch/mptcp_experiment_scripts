'''
Created on Nov 09, 2017

@author: ahmed
'''
#!/usr/bin/env python

import multiprocessing,subprocess,random,sys
from multiprocessing import Process


random.seed(0)
bwlist=["5G","7.5G","10G"]
timelist=["1","5","10"]
destination=sys.argv[1]
childthreads=[]
##
def threadcode(destination,bw,time,port):
        p = subprocess.Popen(["iperf3", "-u", "-c", destination, "-b", bw, "-t", time,"i0", "-p", port], stdout=subprocess.PIPE)
	output, err = p.communicate()
	print  output, err

while 1:
	for port in ["5001","5002"]:
	    bw=random.choice(bwlist)	     
	    time=random.choice(timelist)

	    t=Process(target=threadcode,name="portNumber=%s"%(port),args=(destination,bw,time,port))
		#t.setDaemon(1)            
	    t.start()
	    print t            
	    childthreads.append(t)
	if len(childthreads)<3:
		    for t in childthreads:
		            print t            
		            t.join()
		    childthreads=[]

#     
log.close()
