#!/bin/bash
set -e

echo '+++ Welcome to node-from-git'

# clean-up
if [ -f git_ssh_key ]
then
  rm git_ssh_key
fi

if [ -d node-app ]
then
  rm -rf node-app
fi

GIT_BRANCH=${GIT_BRANCH:-master}

echo '+++ GIT_REPOSITORY     ' $GIT_REPOSITORY
echo '+++ GIT_BRANCH         ' $GIT_BRANCH

if [ ! -z "$GIT_SSH_KEY_BASE64" ]
then
  echo '+++ GIT_SSH_KEY_BASE64  provided'
else
  echo '+++ GIT_SSH_KEY_BASE64  not set'
fi
echo '+++'

if [ -z "$GIT_REPOSITORY" ]
then
  echo 'fatal: environment variable GIT_REPOSITORY is not set' 1>&2
  exit 1
fi

if [ ! -z "$GIT_SSH_KEY_BASE64" ]
then
  echo "$GIT_SSH_KEY_BASE64" > git_ssh_key.b64
  base64 -d git_ssh_key.b64 > git_ssh_key
  rm git_ssh_key.b64
  chmod 600 git_ssh_key
  export GIT_SSH_COMMAND='ssh -i git_ssh_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
fi

git --version
set -v
git clone $GIT_REPOSITORY --branch $GIT_BRANCH --single-branch --depth 1 node-app
cd node-app
export NODE_ENV=production
npm install
npm start
