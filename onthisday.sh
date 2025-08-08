#!/bin/bash

ICAL_FILE="/storage/emulated/0/Documents/scriptsxxx/sexy.ics" # Replace with the path to your .ics file

# Get current month and day
CURRENT_MONTH=$(date +%m)
CURRENT_DAY=$(date +%d)

echo "Events for today (${CURRENT_MONTH}/${CURRENT_DAY}):"
echo "-----------------------------------"

# Read the iCalendar file line by line
while IFS= read -r line; do
    # Look for BEGIN:VEVENT to identify event blocks
    if [[ "$line" =~ ^BEGIN:VEVENT$ ]]; then
        EVENT_START_DATE=""
        EVENT_SUMMARY=""
        
        # Read lines within the event block until END:VEVENT
        while IFS= read -r event_line; do
            if [[ "$event_line" =~ ^DTSTART: ]]; then
                EVENT_START_DATE=$(echo "$event_line" | sed 's/DTSTART:\(.*\)/\1/')
            elif [[ "$event_line" =~ ^DESCRIPTION: ]]; then
                EVENT_SUMMARY=$(echo "$event_line" | sed 's/DESCRIPTION:\(.*\)/\1/')
            elif [[ "$event_line" =~ ^END:VEVENT$ ]]; then
                break # Exit inner loop when event ends
            fi
        done

        # Extract month and day from the event start date (YYYYMMDD format)
        EVENT_MONTH=${EVENT_START_DATE:4:2}
        EVENT_DAY=${EVENT_START_DATE:6:2}

        # Compare month and day, ignoring the year
        if [[ "$EVENT_MONTH" == "$CURRENT_MONTH" && "$EVENT_DAY" == "$CURRENT_DAY" ]]; then
            echo -e "$EVENT_SUMMARY"
        fi
    fi
done < "$ICAL_FILE"