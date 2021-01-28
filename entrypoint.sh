#!/bin/bash
set -e

BASE_BRANCH="remotes/origin/$1"
PATHSPEC=$2
FORK_POINT_SHA=$(git merge-base --fork-point $BASE_BRANCH)

echo ::set-output name=fork_point_sha::$FORK_POINT_SHA

function check() {

  if [[ -z "$(git diff --name-only $FORK_POINT_SHA $PATHSPEC)" ]];
  then
    echo "Detected no changes on $PATHSPEC since $FORK_POINT_SHA"
    echo ::set-output name=changed::false
  else
    echo "Detected changes on $PATHSPEC since $FORK_POINT_SHA"
    echo ::set-output name=changed::true
  fi
}

check
