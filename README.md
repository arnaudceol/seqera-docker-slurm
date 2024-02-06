# Run tower-agent in a slurm environment with docker

This docker image allows to run a single slurm node with apptainer and seqera tower-agent inside, allowing to run nextflow pipelines launched from the Seqera platform on machines without schedulers.

The idea comes from https://community.seqera.io/t/simple-bash-computing-environment/456/3, and is based on an image build by HPCNow https://hub.docker.com/r/hpcnow/slurm_simulator  (see https://hpckp.org/articles/how-to-use-the-slurm-simulator-as-a-development-and-testing-environment/)

Usage:

```bash
export AGENT_CONNECTION_ID=<YOUR CONNECTION ID>
export TOWER_ACCESS_TOKEN=<Your access token>

# Add mount to any needed folder
docker run  -ti -e AGENT_CONNECTION_ID=$AGENT_CONNECTION_ID  -e TOWER_ACCESS_TOKEN=$TOWER_ACCESS_TOKEN--rm  -v work:/work seqera-slurm
```

References:
- https://community.seqera.io/t/simple-bash-computing-environment/456/3
- https://hpckp.org/articles/how-to-use-the-slurm-simulator-as-a-development-and-testing-environment/
- https://tower.nf
- https://docs.seqera.io/platform/23.3.0/supported_software/agent
