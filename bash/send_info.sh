#!/bin/bash

echo "Service started"

BROKER="XX.XX.XX.XX"
USER="user_name"
PASSWD="password"
TOPIC="topic"

SLEEP_SEC=30

while :
do

echo "Gathering system information"

#Get upgradable packages
upg_pac=`apt list --upgradable 2>/dev/null | wc -l`
upg_pac=$(($upg_pac - 1))

#Get uptime in hours
up_h=$(awk '{print $1/3600}' /proc/uptime)

#Get CPU utilization in percents
cpu=`awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1); }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)`

#Get memory usage
ram=`free | grep Mem | awk '{print $3/$2 * 100.0}'`
swap=`free | grep Swap | awk '{print $3/$2 * 100.0}'`

#Get disk usage
disk_total=`df /dev/sda2 | grep /dev/sda2 | awk '{print $2/1024/1024}'`
disk_used=`df /dev/sda2 | grep /dev/sda2 | awk '{print $3/1024/1024}'`

#Transfered data
eth0_rx=`/usr/sbin/ifconfig eth0 | grep 'RX packets' | awk '{print $5/(1000*1000*1000)}'`
eth0_tx=`/usr/sbin/ifconfig eth0 | grep 'TX packets' | awk '{print $5/(1000*1000*1000)}'`
vpn_rx=`/usr/sbin/ifconfig tun0 | grep 'RX packets' | awk '{print $5/(1000*1000*1000)}'`
vpn_tx=`/usr/sbin/ifconfig tun0 | grep 'TX packets' | awk '{print $5/(1000*1000*1000)}'`

payload="{\"uptime\":$up_h,\"upgradable_packages\":$upg_pac,\"disk\":{\"total\":$disk_total,\"used\":$disk_used},\"memory\":{\"ram\":$ram,\"swap\":$swap},\"network\":{\"ens_rx\":$eth0_rx,\"ens_tx\":$eth0_tx,\"vpn_rx\":$vpn_rx,\"vpn_tx\":$vpn_tx},\"cpu\":$cpu}"

echo "Sending system informations through MQTT to Hassio instance"
mosquitto_pub -h $BROKER -t $TOPIC -m $payload -u $USER -P $PASSWD

echo "Sleeping for $SLEEP_SEC seconds"
sleep $SLEEP_SEC
done
