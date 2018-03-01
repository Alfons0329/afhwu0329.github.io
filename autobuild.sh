#!/bin/bash
mkdocs build
mkdocs gh-deploy
git add -u && git add -A
git commit -m "Auto update this repository"
git push
