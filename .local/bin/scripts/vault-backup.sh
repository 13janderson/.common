#!/bin/bash
# For proper use, add this to crontab with crontab -e
# Perform backup of entire vault, not just anything tracked by git
# * * * * * ~/.local/bin/scripts/sh_tools/vault-backup.sh
cd ~/vault/
git pull --no-edit
git add .
timestamp=$(date)
git commit -am "omarchy vault backup: ${timestamp}"
git push
cd -

