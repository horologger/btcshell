FROM alpine:latest
LABEL maintainer="horologger <horologger@protonmail.com>"
FROM horologger/gotty:v1.5.1

RUN apk update && \
    apk upgrade && \
    apk add screen && \
    apk add curl lsof jq vim && \
    apk add htop 

# RUN echo 'echo "gotty"' > /etc/hostname

RUN echo 'echo ""' > /root/.bashrc && \
    echo 'echo "Nothing is started in the background(yet)."' >> /root/.bashrc && \
    echo 'echo "Run htop command to display system info."' >> /root/.bashrc && \
    echo 'echo "Other commands: jq, vim, lsof, bitcoin-cli"' >> /root/.bashrc && \
    echo 'echo "Files are persisted in the /data folder, /data/bin for execs. Run this."' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc  && \
#    echo "export PS1='\h:\w\$ '" >> /root/.bashrc
    echo "export PS1='btcsh:\w\$ '" >> /root/.bashrc

#RUN mkdir -p /data/bin

#RUN echo "echo '#!/bin/bash'" > /data/setpath && \
#    echo "echo 'export PATH=/data/bin:$PATH'" >> /data/setpath

#RUN chmod a+x /data/setpath

WORKDIR /root
ADD ./docker_entrypoint.sh /usr/bin/docker_entrypoint.sh
RUN chmod a+x /usr/bin/docker_entrypoint.sh

USER 0

# Run docker_entrypoint.sh
ENTRYPOINT ["/usr/bin/docker_entrypoint.sh"]