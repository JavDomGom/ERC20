#!/bin/bash

cat input.csv | egrep '^0x' | while read line
do
  ADDRESS=$(echo $line | awk -F"," '{print $1}')
  AMOUNT=$(echo $line | awk -F"," '{print $2}')
  node app.js $ADDRESS $AMOUNT | tee -a log/${ADDRESS}_$(date +%Y-%m-%d-%s).log
  sleep 3
done
