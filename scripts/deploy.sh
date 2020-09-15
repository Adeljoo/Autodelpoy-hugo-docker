#!/bin/sh

while [ 1 ]
do
    echo "Checking for changes in the repo"
    sleep 20
    git pull
done