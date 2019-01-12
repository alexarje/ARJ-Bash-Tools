#!/bin/bash

for i in *.avi; do
 if [ -e "$i" ]; then
   file=`basename "$i" .avi`
   ffmpeg -i "$i" -acodec libfaac -b:a 128k -vcodec mpeg4 -b:v 1200k -vf yadif -vf "transpose=2" -flags +aic+mv4 "$file.mp4"
   ffmpeg -i "$i" -vf "thumbnail" -frames:v 1 -vf "transpose=2" "$file.png"
 fi
done


