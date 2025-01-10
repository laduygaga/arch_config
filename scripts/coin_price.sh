#!/bin/bash
# program to get btc price from coinbase.com

# function get_btc_price() {
# 	btc=`curl -s https://api.coinbase.com/v2/prices/BTC-USD/spot | jq -r '.data.amount'`
# 	# gods=`curl -s https://api.coinbase.com/v2/prices/GODS-USD/spot | jq -r '.data.amount'`
# 	eth=`curl -s https://api.coinbase.com/v2/prices/ETH-USD/spot | jq -r '.data.amount'`
# 	pepe=`curl -s https://api.coinbase.com/v2/prices/PEPE-USD/spot | jq -r '.data.amount' | awk '{printf "%.8f", $1}'`
# 	not=`curl -s https://api.coinbase.com/v2/prices/NOT-USD/spot | jq -r '.data.amount' | awk '{printf "%.4f", $1}'`
# 	echo "BTC:$btc" "ETH:$eth" "PEPE:$pepe" "NOT:$not" > /tmp/coin_price.txt
# }

# program to get btc price from binance
function get_btc_price() {
	btc=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT | jq -r '.price' | awk '{printf "%.2f", $1}'`
	# eth=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=ETHUSDT | jq -r '.price' | awk '{printf "%.2f", $1}'`
	# pepe=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=PEPEUSDT | jq -r '.price' | awk '{printf "%.8f", $1}'`
	# io=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=IOUSDT | jq -r '.price' | awk '{printf "%.4f", $1}'`
	# sol=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=SOLUSDT | jq -r '.price' | awk '{printf "%.4f", $1}'`
	# ton=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=TONUSDT | jq -r '.price' | awk '{printf "%.4f", $1}'`
	# not=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=NOTUSDT | jq -r '.price' | awk '{printf "%.4f", $1}'`
	# doge=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=DOGEUSDT | jq -r '.price' | awk '{printf "%.4f", $1}'`
	# xrp=`curl -s https://api.binance.com/api/v3/ticker/price?symbol=XRPUSDT | jq -r '.price' | awk '{printf "%.4f", $1}'`
	echo "BTC:$btc" > /tmp/coin_price.txt
}



get_btc_price
