#!/bin/bash
mkdocs build
git add -u
git commit -m "auto update"
git push
