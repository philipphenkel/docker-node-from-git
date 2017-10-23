FROM node:alpine

RUN apk add --update bash git openssh-client && rm -rf /var/cache/apk/*
RUN yarn global add serve

USER node
WORKDIR /home/node
COPY clone_and_start.sh /home/node

ENTRYPOINT [ "./clone_and_start.sh" ]
CMD [ "yarn", "start" ]
