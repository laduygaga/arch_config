#!/bin/bash

# Default length is 32 if no argument is provided
LEN=${1:-32}

# 1. Read 'LEN' bytes from /dev/urandom
# 2. Encode to base64
# 3. Delete non-alphanumeric characters (standardizing the token)
# 4. Use 'head' to trim to the exact requested length
token=$(head -c "$LEN" /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c "$LEN")

echo $token | xsel -b
