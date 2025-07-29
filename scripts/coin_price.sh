#!/bin/bash
function get_btc_price() {
	local tmp_file="/tmp/coin_price.txt"
	local old_prices=""
	if [ -f "$tmp_file" ]; then
		old_prices=$(cat "$tmp_file")
	fi

	local old_btc=$(echo "$old_prices" | grep -o 'BTC: [0-9.]*' | awk '{print $2}')
	local old_eth=$(echo "$old_prices" | grep -o 'ETH: [0-9.]*' | awk '{print $2}')
	local old_ton=$(echo "$old_prices" | grep -o 'TON: [0-9.]*' | awk '{print $2}')
	local old_io=$(echo "$old_prices" | grep -o 'IO: [0-9.]*' | awk '{print $2}')

	# Fetch all prices in one go
	local prices=$(curl -s -G 'https://api.binance.com/api/v3/ticker/price' --data-urlencode 'symbols=["BTCUSDT","ETHUSDT","TONUSDT","IOUSDT"]')

	# Extract prices
	local btc=$(echo "$prices" | jq -r '.[] | select(.symbol=="BTCUSDT") | .price' | awk '{printf "%.2f\n", $1}')
	local eth=$(echo "$prices" | jq -r '.[] | select(.symbol=="ETHUSDT") | .price' | awk '{printf "%.2f\n", $1}')
	local ton=$(echo "$prices" | jq -r '.[] | select(.symbol=="TONUSDT") | .price' | awk '{printf "%.2f\n", $1}')
	local io=$(echo "$prices" | jq -r '.[] | select(.symbol=="IOUSDT") | .price' | awk '{printf "%.2f\n", $1}')

	compare_prices() {
		local name=$1
		local old_price=${2:-0}
		local new_price=$3
		local arrow=""

		# Ensure prices are not empty before comparing
		if [ -n "$new_price" ] && [ -n "$old_price" ] && (( $(echo "$new_price > $old_price" | bc -l) )); then
			arrow="↑"
		elif [ -n "$new_price" ] && [ -n "$old_price" ] && (( $(echo "$new_price < $old_price" | bc -l) )); then
			arrow="↓"
		fi
		echo "$name: $new_price$arrow"
	}

	local btc_str=$(compare_prices "BTC" "$old_btc" "$btc")
	local eth_str=$(compare_prices "ETH" "$old_eth" "$eth")
	local ton_str=$(compare_prices "TON" "$old_ton" "$ton")
	local io_str=$(compare_prices "IO" "$old_io" "$io")

	echo "$btc_str $eth_str $ton_str $io_str" > "$tmp_file"
}


get_btc_price
