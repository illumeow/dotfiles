#!/bin/bash

FILE="$1"

# 1. Handle Directories
if [ -d "$FILE" ]; then
    eza --tree --color=always "$FILE" | head -200

# 2. Handle Compressed Files
elif [[ "$FILE" == *.zip ]]; then
    unzip -l "$FILE"
elif [[ "$FILE" == *.tar.gz ]] || [[ "$FILE" == *.tgz ]]; then
    tar -ztvf "$FILE"
elif [[ "$FILE" == *.tar ]]; then
    tar -tvf "$FILE"

# 3. Handle Images (Metadata only, unless using a terminal like Kitty)
elif [[ $(file --mime-type -b "$FILE") == image/* ]]; then
    file "$FILE"

# 4. Default: Text/Code files
else
    bat -n --color=always --line-range :500 "$FILE"
fi
