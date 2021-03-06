#!/usr/bin/python 2.7
import socket
import sys

def grab(ip, portno):
	try:
		s = socket.socket()
		s.connect((ip, portno))
		banner=s.recv(1024)
		s.close()
		return banner
	except Exception, e:
		return e

def main():
	ip = sys.argv[1]
	portno = int(sys.argv[2])
	print grab(ip, portno)

if __name__ == '__main__':
	main()
