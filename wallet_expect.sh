#!/usr/bin/expect -f
# Run walletgpu and auto-send "4" at the prompt
spawn ./walletgen-gpu
expect "Enter option:"
send "6\r"
interact
