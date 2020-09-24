#!/bin/sh

REPOS_FILE=repos.txt
PROCESSES=10

mkdir -p git && cd git
xargs --replace -P$PROCESSES git clone {} < $REPOS_FILE
cd ../

