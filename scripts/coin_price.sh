#!/bin/bash
# program to get btc price from coinbase.com

function get_coin_price() {
	btc=`curl -s https://api.coinbase.com/v2/prices/BTC-USD/spot | jq -r '.data.amount'`
	eth=`curl -s https://api.coinbase.com/v2/prices/ETH-USD/spot | jq -r '.data.amount'`
	usd2vnd=`curl  -s https://v6.exchangerate-api.com/v6/52bc1d8fe1eddb9dc1a2ee4d/latest/USD | jq -r ".conversion_rates.VND"`
	echo "BTC: $btc" "ETH: $eth" "USD: $usd2vnd" > /tmp/coin_price.txt
}

get_coin_price
