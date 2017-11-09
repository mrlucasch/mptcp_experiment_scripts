#!/usr/bin/python


from prettytable import PrettyTable
import sys
import os 

fname = sys.argv[1]

os.mkdir( fname, 0755 );
#descr = raw_input("Why are you running this experiment? ")

print("Why are you running this experiment?")

lines = []
while True:
    line = raw_input()
    if line:
        lines.append(line)
    else:
        break
descr = '\n'.join(lines)



#
#config = PrettyTable(['Config Variable', 'Value'])
#f = open(fname+"_raw_config.txt","r")
outf =  open(fname+"/"+fname+"_readme.txt","w")
#for line in f:
#	parts = line.replace("\n","").split(",")
#	config.add_row(parts)

outf.write("# Description of Experiment\n\n")
outf.write(descr)
outf.write("\n\n\n")
#outf.write("\n\n\n# Configuration\n\n\n")
#outf.write(config.get_string()+"\n")
#print config


#outf.close()
#f.close()
