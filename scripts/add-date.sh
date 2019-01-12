#!/bin/bash

for i in *.txt; do
 if [ -e "$i" ]; then
   cp "$1" `date +%d%b%Y`_"$1"
 fi
done


