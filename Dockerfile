FROM docker.io/hpcnow/slurm_simulator:20.11.9

RUN dnf install -y epel-release  && dnf update -y && \
    dnf remove -y java* && \
    dnf install -y java-11-openjdk curl apptainer

RUN curl -s https://get.nextflow.io | bash && \
 chmod a+xr nextflow && \
 mv nextflow /usr/local/bin

RUN curl -fSL https://github.com/seqeralabs/tower-agent/releases/latest/download/tw-agent-linux-x86_64 > /usr/local/bin/tw-agent && \
    chmod +x /usr/local/bin/tw-agent

COPY start-agent.sh /usr/local/bin/start-agent.sh

RUN chmod +x /usr/local/bin/start-agent.sh

CMD /usr/sbin/init

