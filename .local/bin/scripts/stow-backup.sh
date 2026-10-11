#!/bin/bash

# For proper use, add this to crontab with crontab -e
# Perform scheduled dotfile backup
# * * * * * ~/.local/bin/scripts/stow-backup.sh
cd ~/dotfiles/
git add .
timestamp=$(date)
git commit -am "wsl stow backup: ${timestamp}"
git push
cd -

