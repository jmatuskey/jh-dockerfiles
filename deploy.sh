#!/bin/bash
## check in incremented minor version with tag ##
set -e
docker login

awk -F. '{ OFS=FS; $4++ } 1' ./VERSION > tmp
mv tmp ./VERSION
git add ./VERSION
git commit
sed 's/./ /g' ./VERSION | read -r REPO MAJOR MINOR PATCH
git tag -a `cat ./VERSION` -m 'auto tag version'
git push
git push --tags

docker build -t $REPO:latest .
docker push $REPO:latest
docker tag $REPO:latest $REPO:$MAJOR
docker push $REPO:$MAJOR
docker tag $REPO:latest $REPO:$MAJOR.$MINOR
docker push $REPO:$MAJOR.$MINOR
docker tag $REPO:latest $REPO:$MAJOR.$MINOR.$PATCH
docker push $REPO:$MAJOR.$MINOR.$PATCH
