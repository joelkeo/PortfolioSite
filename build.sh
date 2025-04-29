#!/bin/bash
raco pollen render joel.html.pp
cp joel.html index.html
git add .
git commit -m "another automated build"
git push
