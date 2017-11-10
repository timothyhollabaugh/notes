#!/bin/bash

unset LD_LIBRARY_PATH


echo "Hello"
echo `date` >> /home/tim/Rowan/DigitalSystems/editor_env.txt
echo `printenv` >> /home/tim/Rowan/DigitalSystems/editor_env.txt
#echo `id` >> /home/tim/Rowan/DigitalSystems/editor_args.txt

echo $0 >> /home/tim/Rowan/DigitalSystems/editor_args.txt
echo $@ >> /home/tim/Rowan/DigitalSystems/editor_args.txt

file=$1
line=$2
folder=`dirname $file`

echo $folder $file $line >> /home/tim/Rowan/DigitalSystems/editor_args.txt

/opt/visual-studio-code/bin/code $folder -g $file:$line>> /home/tim/Rowan/DigitalSystems/editor_args.txt

echo "Started Code" >> /home/tim/Rowan/DigitalSystems/editor_args.txt
