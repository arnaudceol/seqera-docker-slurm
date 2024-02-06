FROM docker.io/hpcnow/slurm_simulator:20.11.9

RUN dnf install -y epel-release  && dnf update -y && \
    dnf remove -y java* && \
    dnf install -y java-11-openjdk curl apptainer

RUN curl -s https://get.nextflow.io | bash && \
 chmod a+xr nextflow && \
 mv nextflow /usr/local/bin

COPY start.sh  /
RUN chmod +x start.sh

ENTRYPOINT /start.sh