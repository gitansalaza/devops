#!/bin/bash
# Name:        setup_sshkey.sh
# Description: setup the ssh key
# Usage:       ./setup_sshkey.sh # as the admin user
# Author:      Antonio Salazar (antonio.salazar@ymail.com)
# Date:        2022-04-17
# --------------------------------------------------------

#
# Main
#
read -p 'Please enter the destination hostname or IP address: ' host ;

#
# Setup the SSH keys
#
ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N "" ;
ls  ~/.ssh/id_rsa* ;
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys ;
ssh-copy-id localhost -p 22 ;
ssh-copy-id ${host} -p 22 ;
