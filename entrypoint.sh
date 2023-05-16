#!/bin/bash
set -e

BASE_BRANCH="remotes/origin/$1"
PATHSPEC=${@:2}
FORK_POINT_SHA=$(git merge-base --fork-point $BASE_BRANCH || git merge-base $BASE_BRANCH HEAD)

echo "fork_point_sha=$FORK_POINT_SHA" >>"$GITHUB_OUTPUT"

function check() {

  if [[ -z "$(git diff --name-only $FORK_POINT_SHA $PATHSPEC)" ]];
  then
    echo "Detected no changes on $PATHSPEC since $FORK_POINT_SHA"
    echo "changed=false" >>"$GITHUB_OUTPUT"
  else
    echo "Detected changes on $PATHSPEC since $FORK_POINT_SHA"
    echo "changed=true" >>"$GITHUB_OUTPUT"
  fi
}

check
