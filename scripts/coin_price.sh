#!/bin/bash
# program to get btc price from coinbase.com

function get_btc_price() {
	btc=`curl -s https://api.coinbase.com/v2/prices/BTC-USD/spot | jq -r '.data.amount'`
	gods=`curl -s https://api.coinbase.com/v2/prices/GODS-USD/spot | jq -r '.data.amount'`
	echo "BTC: $btc" "GODS: $gods"
}

get_btc_price
