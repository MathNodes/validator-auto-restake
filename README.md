# validator-auto-restake
Withdraw commission and staking rewards and auto compound

## About
We have our reserves about authz restake. Mostly because we are ill-informed on exactly how the technology works. In our naiveity we believe that authz restake app could potentially lead to wallet compromise. Please feel free to correct us in this assumption as we are still trying to learn.

As such, we have a set a scripts which manage our validator commission retrieval and auto re-stake. It requires the chain hub package (i.e., **bitsongd**) and all that is required is to edit the files according. We run the one script in a cronjob and forget about it. This will autocompound our commission and our staking rewards every x amount of hours. 

## Requirements

* The network daemon for your chain.
* expect
     `sudo apt install expect`
* Create a `keyring-backed file` wallet in your user home directory of choice with the network daemon you are using, i.e.,
	 `bitsongd keys add Validator --recover --keyring-backend file --kering-dir /home/user/Wallet`


## Clone

Clone the github repo and move the `Scripts` folder within the repo to your home directory

```shell
git clone https://github.com/MathNodes/validator-auto-restake && \
cd validator-auto-restake && \
cp -R Scripts ${HOME}
```

## Files to Edit

### `query_rewards_total.sh`

Edit the above variables:

```shell
BITSONGD="/home/bitsong/go/bin/bitsongd"
VALIDATOR_ADDRESS="bitsongvaloper..."
WALLET_ADDRESS="bitsong1..."
RPC="https://rpc.bitsong.quokkastake.io:443"
```

### `stake_rewards.exp`

Edit the following line:

```
spawn ~/go/bin/bitsongd tx staking delegate bitsongvaloper... $AMOUNT --from bitsong1... --chain-id bitsong-2b --gas 300000 --gas-prices 0.3ubtsg --gas-adjustment 1.5 --yes --keyring-backend file --keyring-dir /home/bitsong/Validator --node https://rpc.bitsong.quokkastake.io:443
```

* * `~/go/bin/bitsongd` with the network daemon of your choice. 
* The `bitsongvaloper...` with your validator operator address. 
* The `bitsong1...` with the wallet address of your validator wallet.
* The `--keyring-dir /home/user/WalletLocation` of your keyring-backed file wallet
* The `--node RPC` with the RPC you choose to use. 

Also edit the line:

```
send "password\r"
```

and enter in your wallet keyring passphrase. Making sure to keep the `\r`

### `withdraw_rewards.exp`

Same as `stake_rewards.exp`

## Running

Set up a cronjob to run the following at the interval of your choice:

`crontab -e`

```shell
MAILTO=bitsong@localhost
20 */4 * * * /home/bitsong/Scripts/WithdrawAndStake/withdraw_rewards_and_stake.sh
```

