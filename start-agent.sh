if [[ "$MEMORY" ]]; then
    echo "Node memory assigned: $MEMORY"
else
    totalmemory=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    MEMORY=$(echo "$totalmemory *80 / 100 / 1024" | bc)
    echo "Node memory assigned (80% of total): $MEMORY"
fi

if [[ "$NUMSOCKETS" ]]; then
    echo "Num sockers assigned: $NUMSOCKETS"
else
    NUMSOCKETS=1
    echo "Num socker by default: 1"
fi

if [[ "$NUMCORESPERSOCKET" ]]; then
    echo "Num core per sockets assigned: $NUMCORESPERSOCKET"
else
    totalcores=$(getconf _NPROCESSORS_ONLN)
    NUMCORESPERSOCKET=$(echo "$totalcores *80 / 100" | bc)
    echo "Node cores assigned (80% of total): $NUMCORESPERSOCKET"
fi

echo "NodeName=node001 CPUs=$NUMCORESPERSOCKET RealMemory=$MEMORY State=UNKNOWN Gres=gpu:1" > /etc/slurm/nodes.conf
echo "PartitionName=long Nodes=node001 Default=YES State=UP OverSubscribe=NO MaxTime=14-00:00:00" > /etc/slurm/partitions.conf

systemctl start slurmctld
/bin/bash -c "USER=nextflow tw-agent $AGENT_CONNECTION_ID  --work-dir=/seqera/work/ -u $TOWER_API_ENDPOINT"
