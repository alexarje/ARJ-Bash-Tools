#!/bin/bash

# Script for converting MXF video files to differen to other file formats.

for i in *.MXF; do
 if [ -e "$i" ]; then
   file=`basename "$i" .MXF`
   # MP4 file with default settings + deinterlacing
   ffmpeg -i "$i" -c:v libx264 -vf yadif "$file.mp4"
   # AVI file with MJPEG compression that works with QTM
#   ffmpeg -i "$i" -c:v mjpeg -q:v 3 -acodec pcm_s16le -ar 44100 "$name_conv.avi";
   # Uncompressed audio file
#   ffmpeg -i "$i" -acodec pcm_s16le "$name_conv.wav";
   # Create thumbnail from the first image in the video file
   ffmpeg -i "$i" -vf "thumbnail" -frames:v 1 "$file.png"
 fi
done
