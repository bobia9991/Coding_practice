#!/bin/zsh

set -ue

# Usage
#       In Macos:
#          Store all information of PhD advertisements in the 'Jobs_list.txt' file
#
#       In terminal:
#           cd /Users/binhvo/Library/CloudStorage/OneDrive-Personal/Documents_Mac/Ebooks/Scholarship/motivation_script
#           then run: ./motivation_letter_trigger.sh
#
# This script will call the motivation_letter_Word_file.R file,
# then create a folder naming Supervisor and save a motivation letter to there in the pdf format.

file='./Jobs_list.txt'
code_file='./motivation_letter_Word_file_demo.R'

line_number=1 
# this variable is used for control exactly where the 'sed' command will modify inplace.

while read line || [ -n "$line" ]; do
    supervisor=$(echo $line | cut -d "|" -f2)
    project_name=$(echo $line | cut -d "|" -f3)
    reason_1=$(echo $line | cut -d "|" -f4)
    reason_2=$(echo $line | cut -d "|" -f5)
    done_or_not=$(echo $line | cut -d "|" -f7)
    if [ $done_or_not = "Undone" ]; then # if this value = done, it means that project has an existed motivation file.
        $code_file $supervisor $project_name $reason_1 $reason_2
        sed -i '' "${line_number}s/Undone/Done/g" $file
    fi
    line_number=$(bc --expression="$line_number+1")
done < $file