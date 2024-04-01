#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Don't delete the lock file
rm -rf ~/.config/nvim/lua
rm -rf ~/.config/nvim/init.lua

rsync -a $SCRIPT_DIR/src/ ~/.config/nvim
