FROM node:7-alpine

RUN apk add --update bash git openssh-client && rm -rf /var/cache/apk/*

# Create working directory
RUN mkdir -p /usr/src
WORKDIR /usr/src

# Copy script
COPY clone_and_start.sh /usr/src/

# Start
CMD [ "./clone_and_start.sh" ]
