#!/bin/bash
mkdocs build
mkdocs gh-deploy
git add -u && git add -A

if [ $# -ge 1 ];
then
    git commit -m "$1"
    git push
else
    git commit -m "Auto update this repository"
    git push
fi
