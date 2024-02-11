systemctl start slurmctld
/bin/bash -c "USER=nextflow tw-agent $AGENT_CONNECTION_ID  --work-dir=/work"
