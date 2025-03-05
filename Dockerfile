FROM alpine:latest
LABEL maintainer="horologger <horologger@protonmail.com>"
FROM horologger/gotty:v1.5.2

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
RUN echo "BTC Shell Build Starting...$TARGETPLATFORM"
RUN echo "$TARGETOS : $TARGETARCH : $TARGETVARIANT"

RUN apk add --no-cache yq jq libgcc gcompat; \
    rm -f /var/cache/apk/*

# RUN apk update && \
#     apk upgrade && \
#     apk add screen curl lsof jq yq vim libgcc git && \
#     apk add pkgconfig openssh openssl openssl-libs-static gcompat && \
#     # apk add gcc openssl-dev && \
#     # apk add cargo npm && \
#     apk add htop; \
#     rm -f /var/cache/apk/*

# RUN echo 'echo "gotty"' > /etc/hostname

RUN echo 'echo ""' > /root/.bashrc && \
    echo 'echo "Nothing is started in the background(yet)."' >> /root/.bashrc && \
    echo 'echo "Run htop command to display system info."' >> /root/.bashrc && \
    echo 'echo "Other commands: jq, vim, lsof, bitcoin-cli -getinfo"' >> /root/.bashrc && \
    echo 'echo "Files are persisted in the /data folder, /data/bin for execs."' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc  && \
    echo "export HOME='/root'" >> /root/.bashrc  && \
    echo "alias bitcoin-cli='bitcoin-cli -rpcconnect=$BITCOIN_RPCCONNECT -rpcport=$BITCOIN_RPCPORT -rpcuser=$BITCOIN_RPCUSER -rpcpassword=$BITCOIN_RPCPASSWORD'" >> /root/.bashrc && \
#    echo "export PS1='\h:\w\$ '" >> /root/.bashrc
    echo "export PS1='btcsh:\w\$ '" >> /root/.bashrc

#RUN mkdir -p /data/bin

#RUN echo "echo '#!/bin/bash'" > /data/setpath && \
#    echo "echo 'export PATH=/data/bin:$PATH'" >> /data/setpath

#RUN chmod a+x /data/setpath

WORKDIR /root
ADD ./docker_entrypoint.sh /usr/bin/docker_entrypoint.sh
RUN chmod a+x /usr/bin/docker_entrypoint.sh

COPY ./build_time_tasks.sh /usr/bin/build_time_tasks.sh
RUN chmod a+x /usr/bin/build_time_tasks.sh
RUN /bin/bash /usr/bin/build_time_tasks.sh

USER 0

EXPOSE 8081

# Run docker_entrypoint.sh
ENTRYPOINT ["/usr/bin/docker_entrypoint.sh"]