#!/bin/bash
## This file exists so you can find it without having to search in .git/hooks/pre-commit. That file simply calls this one.
awk -F. '{ OFS=FS; $3++ } 1' VERSION > tmp
mv tmp VERSION
git add VERSION
git tag -a `cat VERSION`
cat ".git/hooks/pre-commit has incremented package version and added to commit!\n"
