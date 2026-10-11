#!/bin/bash

source $HOME/.env_read.sh

# Source language specfic configs
source $HOME/.config/.lang/python.sh
source $HOME/.config/.lang/javascript.sh
source $HOME/.config/.lang/mise.sh
source $HOME/.config/.lang/terraform.sh

# Launch Windows chrome as browser
export BROWSER="omarchy-launch-browser"

# Add mise paths
export PATH="$PATH:$HOME/.local/share/mise/installs/"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin/scripts"
export PATH="$PATH:$HOME/.local/bin/scripts/sh_tools/"

export COPY_CMD="wl-copy"
