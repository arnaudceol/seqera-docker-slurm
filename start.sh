
systemctl start slurmd
systemctl start slurmd

curl -fSL https://github.com/seqeralabs/tower-agent/releases/latest/download/tw-agent-linux-x86_64 > tw-agent
chmod +x tw-agent
./tw-agent $AGENT_CONNECTION_ID  --work-dir=/work