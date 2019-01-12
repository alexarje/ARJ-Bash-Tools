#!/bin/bash

for i in *.MXF;
do
    name=`echo $i | cut -d'.' -f1`;
#    ffmpeg -i "$i" -c:v libx264 -vf yadif "$name_conv.mp4";
done
