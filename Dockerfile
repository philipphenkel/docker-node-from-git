FROM node:alpine

RUN apk add --update bash git openssh-client && rm -rf /var/cache/apk/*

ENV YARN_VERSION 0.23.2
ENV YARN_DIR /opt/yarn
ADD https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v${YARN_VERSION}.tar.gz /opt/yarn.tar.gz
RUN mkdir -p $YARN_DIR && \
    tar -xzf /opt/yarn.tar.gz -C $YARN_DIR && \
    rm /opt/yarn.tar.gz

USER node
WORKDIR /home/node
COPY clone_and_start.sh /home/node

CMD [ "./clone_and_start.sh" ]
