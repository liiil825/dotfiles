#!/usr/bin/env bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git checkout main
git pull origin main
git branch -d $BRANCH
