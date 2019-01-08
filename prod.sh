#!/bin/bash
#begin by resetting SURF working directory to last commit state
git -C ../SURF_PROD reset --hard;
#git pull to sync with remote to avoid collisions
git -C ../SURF_PROD pull origin master;

mv ./fonts ../SURF_PROD/static;

#build for prod (need prod endpoints)
yarn run build;

#get most recent commit and current branch in SURF
lastCommitHash=$(git rev-parse --short HEAD)
lastCommit=$(git log -n 1 --oneline)
branchName=$(git rev-parse --abbrev-ref HEAD)

#cd ./dist;
#git add . ;
git -C ../SURF_PROD add . ;
git -C ../SURF_PROD commit -m "Push on: `(date "+%F %T")` from ${lastCommitHash} on branch ${branchName}" -m "Built version of: ${lastCommit}";
git -C ../SURF_PROD push origin master;
