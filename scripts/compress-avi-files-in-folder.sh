#!/bin/bash

for i in *.avi;
do
    name=`echo $i | cut -d'.' -f1`;
    ffmpeg -i "$i" -c:v mjpeg -q:v 3 -acodec pcm_s16le -ar 44100 "${name}_conv.avi";
#    ffmpeg -i "$i" -acodec pcm_s16le "$name_conv.wav";
#    ffmpeg -i "$i" -c:v libx264 "$name_conv.mp4";
done
