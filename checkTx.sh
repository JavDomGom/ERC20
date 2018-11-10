#!/bin/bash

A_TX=$(ls -l /usr/airdrop/log/*.log 2>/dev/null | wc -l)
B_TX=$(ls -l /usr/bounty/log/*.log 2>/dev/null | wc -l)
A_ERR=$(egrep -il 'error' /usr/airdrop/log/*.log 2>/dev/null | sort -u | wc -l)
B_ERR=$(egrep -il 'error' /usr/bounty/log/*.log 2>/dev/null | sort -u | wc -l)
A_OK=$(expr $A_TX - $A_ERR)
B_OK=$(expr $B_TX - $B_ERR)
A_LIST=$(cat /usr/airdrop/input.csv | wc -l)
B_LIST=$(cat /usr/bounty/input.csv | wc -l)

printf "\tSuccessful\tError\tTotal\tAddresses\n"
printf "Airdrop\t%d\t\t%d\t%d\t%d\n" $A_OK $A_ERR $A_TX $A_LIST
printf "Bounty\t%d\t\t%d\t%d\t%d\n" $B_OK $B_ERR $B_TX $B_LIST
