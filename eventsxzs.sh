#!/bin/sh
i=1
j=1
month=""
day=""
desc=""
descfull=""
begin=""
end=""
rrule=""
name="history.ics"
while [ $j -ne 13 ]
do
while [ $i -ne 32 ]
do
        
        if [ ${#j} -lt 2 ]; then
        month+="0"
        month+="${j}"
        fi
        if [ ${#j} -eq 2 ]; then
        month+="${j}"
        fi
        if [ ${#i} -lt 2 ]; then
        day+="0"
        day+="${i}"
        fi
        if [ ${#i} -eq 2 ]; then
        day+="${i}"
        fi
        echo "BEGIN:VEVENT" >> $name
        begin+="DTSTART:2025"
        begin+="${month}"
        begin+="${day}"
        begin+="T100000Z"
        echo $begin >> $name
        rrule+="RRULE:FREQ=YEARLY;BYMONTH="
        rrule+="${month}"
        rrule+="BYMONTHDAY="
        rrule+="${day}"
        echo $rrule >> $name
        end+="DTEND:2025"
        end+="${month}"
        end+="${day}"
        end+="T100000Z"
        echo $end >> $name
        
        desc+=$(curl https://api.wikimedia.org/feed/v1/wikipedia/en/onthisday/events/$j/$i | jq '.events[] | "\(.year) ':' \(.text)"')
        descfull+="DESCRIPTION:"
        descfull+="${desc}"
        echo $descfull >> $name
        echo "END:VEVENT" >> $name
        day=""
        month=""
        descfull=""
        begin=""
        desc=""
        end=""
        rrule=""
        i=$(($i+1))
done
        j=$(($j+1))
        i=1
done
