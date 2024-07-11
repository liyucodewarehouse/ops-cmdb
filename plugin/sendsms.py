#!/usr/bin/env python

import sys,urllib
msg = sys.argv[1]
formated_msg = urllib.quote(msg)
URL = "http://172.23.20.201:8080/sendSMS?content="
f=urllib.urlopen(URL+formated_msg)
s=f.read()

with open("/tmp/sms.log","a") as file:
    file.writelines(URL+formated_msg+"\n")
    file.writelines(s+"\n")

