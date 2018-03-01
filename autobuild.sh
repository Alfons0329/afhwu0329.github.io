#!/bin/bash
mkdocs build
cd my-website
git add -u 
git commit -m "auto update"
git push origin master
