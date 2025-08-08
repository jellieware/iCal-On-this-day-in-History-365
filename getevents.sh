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
        desc+=$(curl https://api.wikimedia.org/feed/v1/wikipedia/en/onthisday/events/$j/$i | jq '.events[] | "\(.year) ':' \(.text)/r/n/r/n"')
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
        begin+="DTSTART:2024"
        begin+="${month}"
        begin+="${day}"
        begin+="T100000Z"
        echo $begin >> $name
        rrule+="RRULE:FREQ=YEARLY"
        echo $rrule >> $name
        end+="DTEND:2024"
        end+="${month}"
        end+="${day}"
        end+="T100000Z"
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
        fi
        i=$(($i+1)) 
        
done
        j=$(($j+1))
        i=1
done
