#!/bin/bash

function get_btc_price() {
	btc=`curl -s https://api.coinbase.com/v2/prices/BTC-USD/spot | jq -r '.data.amount'`
	eth=`curl -s https://api.coinbase.com/v2/prices/ETH-USD/spot | jq -r '.data.amount'`
	# only .%4f is supported in jq
	not=`curl -s https://api.coinbase.com/v2/prices/NOT-USD/spot | jq -r '.data.amount' | awk '{printf "%.5f\n", $1}'`
	echo "BTC: $btc" "ETH: $eth" "NOT: $not" > /tmp/coin_price.txt
}

get_btc_price
