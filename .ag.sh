#!/bin/bash
git add --all
git commit -m $(date +%Y/%m/%d/%H/%M)
git push origin master
