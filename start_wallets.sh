#!/bin/bash

for i in {1..4}
do
    echo "4" | screen -dmS wallet$i ./walletgen-gpu
done
