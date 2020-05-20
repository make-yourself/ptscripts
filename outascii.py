#!/usr/local/bin/python
import sys
import textwrap

if len(sys.argv) != 2:
	print "syntax like: outascii.py <file>"
	sys.exit()
fil = open(sys.argv[1],'rb')
remember = fil.read()
fil.close()

for wraparound in textwrap.wrap(remember, 80):
	print "\"%s\"" % wraparound