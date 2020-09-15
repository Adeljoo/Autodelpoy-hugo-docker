#!/bin/bash

# Initiate the repository first
git clone https://${GIT_TOKEN}:x-oauth-basic@github.com/kpn-dsh/dsh_doc_site.git /site

# Go into the site
cd /site

# Start background process to pull from git in intervals
source /scripts/deploy.sh &

# Start CMD line
"$@"