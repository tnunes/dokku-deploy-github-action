#!/bin/bash

SSH_PRIVATE_KEY=$1
DOKKU_USER=$2
DOKKU_HOSTNAME=$3
DOKKU_HOSTPORT=$4
DOKKU_APP_NAME=$5
DOKKU_REMOTE_BRANCH=$6
GIT_PUSH_FLAGS=$7

# Setup the SSH environment
mkdir -p ~/.ssh
eval `ssh-agent -s`
ssh-add - <<< "$SSH_PRIVATE_KEY"
ssh-keyscan -p $DOKKU_HOSTPORT $DOKKU_HOSTNAME >> ~/.ssh/known_hosts

# Setup the git environment
git_repo="$DOKKU_USER@$DOKKU_HOSTNAME:$DOKKU_APP_NAME"
cd "$GITHUB_WORKSPACE"
git remote add deploy "$git_repo"

# Prepare to push to Dokku git repository
REMOTE_REF="$GITHUB_SHA:refs/heads/$DOKKU_REMOTE_BRANCH"

GIT_COMMAND="git push deploy $REMOTE_REF $GIT_PUSH_FLAGS"
echo "GIT_COMMAND=$GIT_COMMAND"

# Push to Dokku git repository
GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $DOKKU_HOSTPORT" $GIT_COMMAND
