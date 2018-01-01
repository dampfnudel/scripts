#!/usr/bin/env osascript

set desktop_path to path to desktop as string
tell application "iCal"
    set the_cals to every calendar
    repeat with each_cal in the_cals
        set the_events to (every event of each_cal whose start date > (current date))
        if the_events is not {} then
            set cal_name to name of each_cal
            set event_data to ""
            repeat with each_event in the_events
                set event_data to event_data & (start date of each_event as text) & return & summary of each_event & return & description of each_event & return
            end repeat
            set eventfilename to desktop_path & cal_name & ".txt"
            try
                set eventfilecontent to (open for access file eventfilename with write permission)
                write event_data to eventfilecontent
            on error
                close access eventfilecontent
            end try
            close access eventfilecontent
        end if
    end repeat
end tell
