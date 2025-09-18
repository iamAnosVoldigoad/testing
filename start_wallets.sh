#!/bin/bash

for i in {1..4}
do
    screen -dmS wallet$i ./wallet_expect.sh
done
