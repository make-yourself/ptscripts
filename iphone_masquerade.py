#!/usr/bin/python
from scapy.all import *

#Python-Scapy script to masquerade as iphone against NAC/IDS

<<<<<<< HEAD
DSTIP="10.20.0.1" #<<target where NAC will observe request
=======
DSTIP="10.10.10.10" #<<target where NAC will observe request
>>>>>>> 0512e6e6e8a1d68552dfd529e1af3f15454a2957
SPORT=RandNum(1024,65535) #Send Port

ip=IP(dst=DSTIP, flags="DF", ttl=64)
#ip layer

tcpopt = [ ("MSS",1460), ("NOP",None), ("Wscale",2), ("NOP",None), ("NOP",None), ("Timestamp",(123,0)), ("SAckOK",""), ("EOL",None) ]
SYN=TCP(sport=SPORT, dport=80, flags="S", seq=10, windows=0xffff, options=tcpopt)
SYNACK=sr1(ip/SYN)	#<^send packet then record response SYNACK

my_ack = SYNACK.seq + 1 # SYN/ACK response grabs initial seq number
ACK=TCP(sport=SPORT, dport=80, flags="A", seq=11, ack=my_ack, windows=0xffff)
send(ip/ACK)
#tcp layer

data = "GET / HTTP/1.1\r\nHost: " + DSTIP + "\r\ Mozilla/5.0 (iPhone; CPU iPhone OS 12_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/14.0b12646 Mobile/16B92 Safari/605.1.15\r\n\r\n"
	#iphone user agent string
PUSH=TCP(sport=SPORT,dport=80, flags="PA", seq=11, ack=my_ack, windows=0xffff)
send(ip/PUSH/data)
#application layer

RST=TCP(sport=SPORT,dport=80, flags="R", seq=11, ack=0, windows=oxffff)
send(ip/RST)
