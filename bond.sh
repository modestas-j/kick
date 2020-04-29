#!/bin/bash
echo -e "DEVICE=bond0\nBOOTPROTO=static\nONBOOT=yes\nNM_CONTROLLED=no\nTYPE=Bond\nIPADDR=`ifconfig eth0 | grep "inet addr" | awk {'print $2'} | tr -d addr:`\nNETMASK=`ifconfig eth0 | grep "inet addr" | awk {'print $4'} | tr -d Mask:`\nGATEWAY=`ip route ls | grep default | awk {'print $3'}`\nDNS1=8.8.8.8\nDNS2=8.8.4.4" >> /etc/sysconfig/network-scripts/ifcfg-bond0
rm -rf /etc/sysconfig/network-scripts/ifcfg-eth*
echo -e "DEVICE=eth0\nHWADDR=`ifconfig eth0 | grep HWaddr | awk {'print $5'}`\nTYPE=Ethernet\nONBOOT=yes\nNM_CONTROLLED=no\nMASTER=bond0\nSLAVE=yes" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo -e "DEVICE=eth0\nTYPE=Ethernet\nONBOOT=yes\nNM_CONTROLLED=no\nMASTER=bond0\nSLAVE=yes" >> /etc/sysconfig/network-scripts/ifcfg-eth1
echo -e "alias bond0 bonding\noptions bond0 mode=4 miimon=100" >> /etc/modprobe.d/bonding.conf
service network restart
