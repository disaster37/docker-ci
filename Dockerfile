FROM redhat/ubi8-minimal:8.4

ENV GID=1000 \
    UID=1000 \
    GROUP=user \
    USER=user \
    HOME=/home/user

# Add some standard tools
RUN microdnf install -y sudo git wget curl ca-certificates zip vim make bash tar gzip jq

# Create user
RUN \
    groupadd --gid ${GID} ${GROUP} && \
    useradd -c "User for che" -d ${HOME} -m -g ${GROUP} -s /bin/bash -u ${UID} ${USER} &&\
    echo "%${GROUP} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${GROUP}


# Clean
RUN \
    microdnf clean all && \
    rm -rf /tmp/* /var/tmp/*
