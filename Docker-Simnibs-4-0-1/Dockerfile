FROM ubuntu:18.04
#RUN useradd -u 8877 amiklos
# Change to non-root privilege
#USER root

SHELL ["/bin/bash", "-c"]

COPY simnibs_installer_linux.tar.gz /simnibs_installer_linux.tar.gz
RUN tar -xzf simnibs_installer_linux.tar.gz
RUN chmod 777 simnibs_installer/install
RUN simnibs_installer/install -s

RUN /root/SimNIBS-4.0/simnibs_env/bin/pip3 install jupyter

ENV PATH /root/SimNIBS-4.0/simnibs_env/bin:$PATH
ENTRYPOINT ["/bin/bash"]
