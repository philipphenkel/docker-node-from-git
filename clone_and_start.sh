#!/bin/bash
set -e

GIT_BRANCH=${GIT_BRANCH:-master}

echo '+++ Welcome to node-from-git'
echo '+++ GIT_URL            ' $GIT_URL
echo '+++ GIT_BRANCH         ' $GIT_BRANCH
if [ ! -z "$GIT_SSH_KEY_BASE64" ]
then
  echo '+++ GIT_SSH_KEY_BASE64  provided'
  echo "$GIT_SSH_KEY_BASE64" > git_ssh_key.b64
  base64 -d git_ssh_key.b64 > git_ssh_key
  chmod 600 git_ssh_key
  export GIT_SSH_COMMAND='ssh -i git_ssh_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
else
  echo '+++ GIT_SSH_KEY_BASE64  not set'
fi
echo '+++'

set -v
node --version
npm --version
git --version
git clone $GIT_URL --branch $GIT_BRANCH --single-branch --depth 1 node-app

cd node-app
export NODE_ENV=production
npm install
npm start
