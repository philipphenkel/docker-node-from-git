FROM node:alpine

RUN apk add --update bash git openssh-client && rm -rf /var/cache/apk/*

USER node
WORKDIR /home/node
COPY clone_and_start.sh /home/node

CMD [ "./clone_and_start.sh" ]
