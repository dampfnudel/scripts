#!/usr/bin/env python

'''
parse a given ical file and print the future events as org-mode todos
'''

from icalendar import Calendar, Event
from datetime import datetime
from pytz import UTC
from datetime import datetime, timezone
from sys import exit, argv


NODE_TEMPLATE = '* TODO {}\nSCHEDULED: <{}>'


def is_full_day(start, end):
    delta = end - start
    if delta.days == 1:
        return True
    else:
        return False
    

def is_in_future(a_date):
    today = datetime.today().date()
    if type(a_date) == datetime:
        a_date = a_date.date()
    if a_date > today:
        return True
    else:
        return False


def get_future_todos(ics):
    with open(ics, 'r') as f:
        nodes = []
        gcal = Calendar.from_ical(f.read())
        for component in gcal.walk():
            if component.name == "VEVENT":
                try:
                    dtstart_dt = component.get('dtstart').dt
                    dtend_dt = component.get('dtend').dt
                except AttributeError:
                    continue

                if not is_in_future(dtstart_dt):
                    continue

                if is_full_day(dtstart_dt, dtend_dt):
                    date_part = dtstart_dt.strftime('%Y-%m-%d %a')
                else:
                    # UTC hack
                    hour = int(dtstart_dt.strftime('%H'))
                    date_part = dtstart_dt.strftime('%Y-%m-%d %a {}:%M'.format(hour +1))

                summary = component.get('summary')
                node = NODE_TEMPLATE.format(summary, date_part)
                nodes.append(node)

        return nodes


if __name__ == "__main__":
    if len(argv) > 1:
        ics = argv[1]
        nodes = get_future_todos(ics)
        for n in nodes:
            print(n)
        exit(0)
    else:
        print('argument required')
        exit(1)
