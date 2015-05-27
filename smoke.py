# -*- coding: utf-8 -*-

from datetime import datetime, timedelta
from time import strftime, gmtime


d_last = datetime(year=2015, month=5, day=10, hour=2)

d_now = datetime.now()

delta = d_now - d_last
days = int(delta.days)

print d_last.strftime("last cigarette: %A, %d. %B %Y %H:%S")

# print strftime("%d days, %H:%M:%S since the last cigarette", gmtime(delta.seconds))
print "smoke-free since %s" % delta

euros = days * 5
print "%i € saved" % euros

cigarettes = days  * 21
print "%i cigarettes unsmoked" % cigarettes

secs = cigarettes * 300
print strftime("%d days, %H:%M:%S smoke time unsmoked", gmtime(secs))
