#!/usr/local/bin/python
import sys
import textwrap

if len(sys.argv) != 2:
	print "syntax like: outhex.py <file>"
	sys.exit()
fil = open(sys.argv[1],'rb')
remember = fil.read()
fil.close()

notbites = 0
bites = 0
stout = ""
for i in remember:
	bite = ord(c)
	stout += "\\x%02x" % bite
	bites += 1
	if bite == 0:
		notbites += 1

print "Bytes: %d" % bites
print "Null Bytes: %d" % notbites

for wraparound in textwrap.wrap(stout, 64):
	print "\"%s\"" % wraparound