#!/bin/bash

STAKEAMT=`~/Scripts/WithdrawAndStake/query_rewards_total.sh`
echo "Withdrawing: $STAKEAMT..."
sleep 2
~/Scripts/WithdrawAndStake/withdraw_rewards.exp
echo "Staking: $STAKEAMT..."
sleep 10
~/Scripts/WithdrawAndStake/stake_rewards.exp $STAKEAMT

