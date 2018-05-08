#!/bin/sh

# -----------------------------------------
# Node js
# -----------------------------------------
# Keep global modules in ~/.node_modules
#
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules
