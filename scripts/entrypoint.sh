#!/bin/bash

# Initiate the repository first
git clone https://${GIT_TOKEN}:x-oauth-basic@github.com/git-handel/reponame.git /site

# Go into the site
cd /site

# Start background process to pull from git in intervals
source /scripts/deploy.sh &

# Start CMD line
"$@"
