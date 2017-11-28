#!/bin/bash
service="minetest";
start=0;
backup=true;

while true
do
sleep 1
if [[ $(date +%H) -eq 4 && $(date +%M) -eq 0 && $(date +%S) -eq 0 ]]
then
foldername=$(date "+%d-%m-%Y")
backup=false
killall minetest
mkdir -p /home/user/backup/"$foldername"
cp /home/user/.minetest/debug.txt /home/user/backup/"$foldername"/
cp /home/user/.minetest/worlds/world/map.sqlite /home/user/backup/"$foldername"/
echo -n "" > /home/user/.minetest/debug.txt
minetest --server &
((start++))
backup=true

elif ps ax | grep -v grep | grep $service > /dev/null ; then
start=0
elif [[ $start -eq 3 ]]; then
start=3
elif $backup && ! ps ax | grep -v grep | grep $service ; then
minetest --server &((start++))
fi
done
