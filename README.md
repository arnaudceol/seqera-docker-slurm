# Run tower-agent in a slurm environment with docker

This docker image allows to run a single slurm node with apptainer and seqera tower-agent inside, allowing to run nextflow pipelines launched from the Seqera platform on machines without schedulers.

The idea comes from https://community.seqera.io/t/simple-bash-computing-environment/456/3, and is based on an image build by HPCNow https://hub.docker.com/r/hpcnow/slurm_simulator  (see https://hpckp.org/articles/how-to-use-the-slurm-simulator-as-a-development-and-testing-environment/)

Usage:

```bash
export AGENT_CONNECTION_ID=<YOUR CONNECTION ID>
export TOWER_ACCESS_TOKEN=<Your access token>

export TOWER_ACCESS_TOKEN="eyJ0aWQiOiAzMn0uNzcxMWJkOGUwZGY4ZGQ5NTcwODM3NWUyMWU0YTdjYzI0NzZmYzUxYw=="
export AGENT_CONNECTION_ID=9eb6812b-789e-4fc3-ab30-0c59a682e5a8
export TOWER_API_ENDPOINT=https://seqera.ieo.it/api

# TOKEN RADIOMICSGPU: eyJ0aWQiOiAzMn0uNzcxMWJkOGUwZGY4ZGQ5NTcwODM3NWUyMWU0YTdjYzI0NzZmYzUxYw==




docker run --rm --detach  \
    --name slurm \
    -h "slurm-simulator" \
    --gpus all \
    --security-opt seccomp:unconfined \
    --privileged -e container=docker \
    -v /run -v /sys/fs/cgroup:/sys/fs/cgroup \
    --cgroupns=host \
    -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN  \
    -e TOWER_API_ENDPOINT=$TOWER_API_ENDPOINT \
    -v /data/nanopore_dare/seqera:/seqera  \
    -v /data/nanopore_dare/scratch:/scratch  \
    -v /data/nanopore_dare/raw:/data/raw/:ro
    -v /data_reference:/data/refData \
    -v /data/nanopore_dare/output:/data/output \
    ghcr.io/arnaudceol/seqera-docker-slurm:main




docker run --rm --detach  \
    --name slurm \
    -h "slurm-simulator" \
    --gpus all \
    --security-opt seccomp:unconfined \
    --privileged -e container=docker \
    -v /run -v /sys/fs/cgroup:/sys/fs/cgroup \
    --cgroupns=host \
    -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN  \
    -e TOWER_API_ENDPOINT=$TOWER_API_ENDPOINT \
    -v /data/alphafold/seqera:/seqera  \
    -v /data/alphafold/scratch:/scratch  \
    -v /data_reference:/data/refData \
    -v /data/alphafold/output:/data/output \
    ghcr.io/arnaudceol/seqera-docker-slurm:main

VM:

creare 
- /data/alphafold/scratch
- /data/alphafold/seqera
- /data/alphafold/output


- /data/

Quindi le cartelle da usare sarebbero:
/sratch/
/seqera/launch/
/seqera/work/
/data/output
/data/input/
/data/refData
 
sulla VM alphafold, ad esempio i volume montati sarebbero quindi:
 
/data/alphafold/seqera -> /seqera
 
/data/alphafold/output -> /data/output/
 
/data_reference -> /data/refData
 


docker run --rm --detach   \
 --name slurm \
 -h "slurm-simulator" \
 --security-opt seccomp:unconfined     --privileged -e container=docker     -v /run -v /sys/fs/cgroup:/sys/fs/cgroup     --cgroupns=host     -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN      -e TOWER_API_ENDPOINT=$TOWER_API_ENDPOINT     -v /data/${PROJECT}/launch:/data/${PROJECT}/launch:Z      -v /data/${PROJECT}/work:/data/${PROJECT}/work:Z      -v /data/${PROJECT}_dare:/data/${PROJECT}_dare:Z      -v /data_reference/alphafold-db:/data/refdata/:Z     ghcr.io/arnaudceol/seqera-docker-slurm:main

docker run --rm --detach  \
    --name slurm \
    -h "slurm-simulator" \
    --gpus all \
    --security-opt seccomp:unconfined \
    --privileged -e container=docker \
    -v /run -v /sys/fs/cgroup:/sys/fs/cgroup \
    --cgroupns=host \
    -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN  \
    -e TOWER_API_ENDPOINT=$TOWER_API_ENDPOINT \
    -v /data/${PROJECT}/launch:/data/${PROJECT}/launch:Z    \
    -v /data/${PROJECT}/work:/data/${PROJECT}/work:Z   \
    -v /data/${PROJECT}_dare:/data/${PROJECT}_dare:Z    \
    -v /data_reference/alphafold-db:/data/refdata/:Z  \
    ghcr.io/arnaudceol/seqera-docker-slurm:main


# Add mount to any needed folder
docker run --rm --detach  \
    --name slurm \
    -h "slurm-simulator" \
    --gpus all \
    --security-opt seccomp:unconfined \
    --privileged -e container=docker \
    -v /run -v /sys/fs/cgroup:/sys/fs/cgroup \
    --cgroupns=host \
    -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN  \
    -e TOWER_API_ENDPOINT=$TOWER_API_ENDPOINT \
    -v /data/radiomicsgpu/work:/work  \
    -v /data:/data  \
    -v /data_reference:/data_reference \
    ghcr.io/arnaudceol/seqera-docker-slurm:main

 --privileged -e container=docker \

GÉANT is the collaboration of European National Research and Education Networks (NRENs). Together we deliver an information ecosystem of infrastructure and services to advance research, education, and innovation on a global scale.
# Run the agent:
docker exec slurm bash -c start-agent.sh
```

```bash
docker run  -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN --rm -ti  --name slurm  \
-v work:/work  \
--security-opt seccomp:unconfined \
--privileged -e container=docker \
-v /run -v /sys/fs/cgroup:/sys/fs/cgroup \
--cgroupns=host seqera-slurm /usr/sbin/init
```

References:
- https://community.seqera.io/t/simple-bash-computing-environment/456/3
- https://hpckp.org/articles/how-to-use-the-slurm-simulator-as-a-development-and-testing-environment/
- https://tower.nf
- https://docs.seqera.io/platform/23.3.0/supported_software/agent


export AGENT_CONNECTION_ID=6e37e2e5-9ab1-4162-a911-d817a7769eee
export TOWER_ACCESS_TOKEN=eyJ0aWQiOiA4ODA3fS5mYmIwZDU5OWNjZGMxMmU2NDJlN2YxZDAyMGUyZDNiM2NlNDI2ZWQz

docker run  -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN --rm -ti  --name slurm  ghcr.io/arnaudceol/seqera-docker-slurm:main



docker run  -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN --rm  -v /data_reference/alphafold-db:/data_reference/alfafold-db:ro   -v /data/alphafold:/data/alphafold  -v /data/alphafold/seqera:/work --group-add keep-groups -d --name slurm  ghcr.io/arnaudceol/seqera-docker-slurm:main

docker run  -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN --rm -ti  --name slurm  -v work:/work seqera-slurm

setsebool -P container_manage_cgroup on

docker run   -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN --rm    -v /data/alphafold/seqera:/work -d --name slurm  ghcr.io/arnaudceol/seqera-docker-slurm:main


nextflow run nf-core/proteinfold     --input samplesheets/test.csv     --outdir output     --mode alphafold2     --alphafold2_mode split_msa_prediction     --alphafold2_db /data_reference/alphafold-db/     --full_dbs true    --alphafold2_model_preset monomer     --use_gpu true     -profile singularity