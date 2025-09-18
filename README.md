Let's start fresh. I have a linux system and I want to run a particular same program which requires same input (input is 4) when it starts in detached screen x10 times I have ubuntu 24.04 And the terminal script file i want to run is walletgpu

Perfect, thanks for clarifying 🙌
You’re on Ubuntu 24.04, and you want to:
Run the same program walletgpu
Each run should start in a detached screen session
Each run requires the same input ("4") when it starts
You want 10 separate detached sessions running it

🔹 Step 1: Test one instance manually
Run this command:
echo "4" | screen -dmS wallet1 ./walletgpu

echo "4" supplies the input.
screen -dmS wallet1 starts a detached screen named wallet1.
./walletgpu runs your program (assuming it’s in the current directory).

Check it’s running:
screen -ls
You should see wallet1.
Attach to verify:
screen -r wallet1


🔹 Step 2: Create a small launcher script
Make a script called start_wallets.sh:
#!/bin/bash

for i in {1..10}
do
    echo "4" | screen -dmS wallet$i ./walletgpu
done

Save it in the same directory as walletgpu, then make it executable:
chmod +x start_wallets.sh
Run it manually once to test:
./start_wallets.sh
Now you should see 10 detached screens:
screen -ls


🔹 Step 3: Run automatically at boot (systemd way)
Create a service file:
sudo nano /etc/systemd/system/wallets.service

Put this inside:
[Unit]
Description=Run 10 walletgpu instances in detached screens at startup
After=network.target

[Service]
User=yourusername
WorkingDirectory=/home/yourusername/path/to/walletgpu
ExecStart=/home/yourusername/path/to/start_wallets.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target

⚠️ Replace yourusername and /home/yourusername/path/to/ with your real path.


🔹 Step 4: Enable and start
Reload systemd and enable:
sudo systemctl daemon-reload
sudo systemctl enable wallets.service
sudo systemctl start wallets.service


✅ Now, on every boot, Ubuntu will start 10 detached screen sessions running walletgpu, each automatically getting the input 4.
You can check them anytime with:
screen -ls
And attach to one with:
screen -r wallet5



