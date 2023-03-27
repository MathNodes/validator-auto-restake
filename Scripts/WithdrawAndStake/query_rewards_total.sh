#!/bin/bash

SATOSHI=1000000
BITSONGD="/home/bitsong/go/bin/bitsongd"
VALIDATOR_ADDRESS="bitsongvaloper..."
WALLET_ADDRESS="bitsong1..."
RPC="https://rpc.bitsong.quokkastake.io:443"

#echo "Querying Comission..."
sleep 2
COMMISSION=`$BITSONGD query distribution commission $VALIDATOR_ADDRESS --node $RPC | grep -B 1 "ubtsg" | grep -o '".*"' | sed -e 's/\"//g'`
#CDEC=`echo "scale=6;$COMMISSION / $SATOSHI" | bc`
#echo "$CDEC DEC"
#echo " "
#echo "Querying Rewards..."
sleep 1
REWARDS=`$BITSONGD query distribution rewards $WALLET_ADDRESS $VALIDATOR_ADDRESS --node $RPC | grep -B 1 "ubtsg"  | grep -o '".*"' | sed -e 's/\"//g'`
RDEC=`echo "scale=6; $REWARDS / $SATOSHI" | bc`
#echo "$RDEC DEC"
#echo " "
TOTAL=`echo "scale=6;$COMMISSION + $REWARDS" | bc`
printf "%.6fubtsg\n" $TOTAL

