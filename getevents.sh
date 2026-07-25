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
uid=""
stamp=""
name="history.ics"
while [ $j -ne 13 ]
do
while [ $i -ne 32 ]
do
        desc+=$(curl https://api.wikimedia.org/feed/v1/wikipedia/en/onthisday/events/$j/$i | jq '.events[] | "\(.year) ':' \(.text)/n"')
        if [[ -n "$desc" ]]; then
    
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
        uid+="UID:2024"
        uid+="${month}"
        uid+="${day}"
        uid+="T100000Z-lexaterra@proton.me"
        echo $uid >> $name
        stamp+="DTSTAMP:2024"
        stamp+="${month}"
        stamp+="${day}"
        stamp+="T100000Z"
        echo $stamp >> $name
        begin+="DTSTART;VALUE=DATE:2024"
        begin+="${month}"
        begin+="${day}"
        echo $begin >> $name
        rrule+="RRULE:FREQ=YEARLY;count=100;BYMONTH="
        rrule+="${month}"
        echo $rrule >> $name
        end+="DTEND;VALUE=DATE:2024"
        end+="${month}"
        end+="${day}"
        echo $end >> $name
        
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
        uid=""
        stamp=""
        fi
        i=$(($i+1)) 
        sleep 5
        
done
        j=$(($j+1))
        i=1
done
