#!/bin/bash

# function get_btc_price() {
# 	btc=`curl -s https://api.coinbase.com/v2/prices/BTC-USD/spot | jq -r '.data.amount'`
# 	eth=`curl -s https://api.coinbase.com/v2/prices/ETH-USD/spot | jq -r '.data.amount'`
# 	not=`curl -s https://api.coinbase.com/v2/prices/NOT-USD/spot | jq -r '.data.amount' | awk '{printf "%.5f\n", $1}'`
# 	pepe=`curl -s https://api.coinbase.com/v2/prices/PEPE-USD/spot | jq -r '.data.amount' | awk '{printf "%.7f\n", $1}'`
# 	echo "BTC: $btc" "ETH: $eth" "NOT: $not" "PEPE:$pepe" > /tmp/coin_price.txt
# }

# get price from binance instead
function get_btc_price() {
	btc=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT | jq -r '.price' | awk '{printf "%.2f\n", $1}'`
	# eth=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=ETHUSDT | jq -r '.price' | awk '{printf "%.2f\n", $1}'`
	# not=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=NOTUSDT | jq -r '.price' | awk '{printf "%.5f\n", $1}'`
	# pepe=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=PEPEUSDT | jq -r '.price' | awk '{printf "%.7f\n", $1}'`
	# io=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=IOUSDT | jq -r '.price' | awk '{printf "%.2f\n", $1}'`
	# sol=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=SOLUSDT | jq -r '.price' | awk '{printf "%.2f\n", $1}'`
	# doge=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=DOGEUSDT | jq -r '.price' | awk '{printf "%.4f\n", $1}'`
	# ton=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=TONUSDT | jq -r '.price' | awk '{printf "%.2f\n", $1}'`
	# xrp=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=XRPUSDT | jq -r '.price' | awk '{printf "%.4f\n", $1}'`
	# echo "BTC: $btc" "SOL: $sol" "DOGE: $doge" "TON: $ton" "XRP: $xrp" > /tmp/coin_price.txt
	echo "BTC: $btc" > /tmp/coin_price.txt
}


get_btc_price
