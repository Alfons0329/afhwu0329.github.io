#!/bin/bash
mkdocs build
mkdocs gh-deploy
git add -u && git add -A

if [ $# -ge 2 ];
then
    git commit -m $2
    git push
else
    git commit -m "Auto update this repository"
    git push
fi
