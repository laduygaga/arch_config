#!/usr/bin/env bash

KEY_FILE=".apikey"

if [[ ! -f "$KEY_FILE" ]]; then
    echo "Error: $KEY_FILE file not found!"
    exit 1
fi

echo "Scanning keys in $KEY_FILE..."
echo "=================================================="

line_num=0
while IFS= read -r key || [[ -n "$key" ]]; do
    # Strip whitespace, carrage returns, and skip empty lines or comments
    key=$(echo "$key" | tr -d '\r' | xargs)
    [[ -z "$key" || "$key" == \#* ]] && continue
    
    ((line_num++))
    
    # Mask key for secure display (e.g., AIzaSy...1234)
    masked_key="${key:0:7}...${key: -4}"
    
    # Hit the basic model meta endpoint to verify key status
        # -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:generateContent?key=${key}" \
	model="gemini-3.1-flash-lite"
	# model="gemini-2.5-flash"
    response=$(curl -s -w "\n%{http_code}" \
        -X POST "https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${key}" \
        -H "Content-Type: application/json" \
        -d '{"contents": [{"parts":[{"text": "ping"}]}]}')

    # Separate the body response and the HTTP status code
    http_status=$(echo "$response" | tail -n1)
    response_body=$(echo "$response" | sed '$d')

    if [[ "$http_status" -eq 200 ]]; then
        echo -e "Line $line_num [$masked_key] -> \033[0;32m✅ VALID (Working fine)\033[0m"
    else
        # Extract the specific error message from the JSON response if available
        err_msg=$(echo "$response_body" | grep -o '"message": "[^"]*' | head -n1 | cut -d'"' -f4)
        [[ -z "$err_msg" ]] && err_msg="HTTP Error $http_status"
        
        if [[ "$response_body" == *"PERMISSION_DENIED"* ]]; then
            echo -e "Line $line_num [$masked_key] -> \033[0;31m❌ BLOCKED ($err_msg)\033[0m"
        else
            echo -e "Line $line_num [$masked_key] -> \033[0;33m⚠️  FAILED ($err_msg)\033[0m"
        fi
    fi
done < "$KEY_FILE"

echo "=================================================="
echo "Done checking all keys."
