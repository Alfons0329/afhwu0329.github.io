#!/bin/bash
mkdocs build
cd mysite
git add -u && git add -A
git commit -m "auto update"
git push origin master
cd mysite
mkdocs serve
