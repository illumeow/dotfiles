#!/usr/bin/env bash

# Tokyonight Color Palette (24-bit ANSI codes)
INFO="\e[38;2;122;162;247m"   # Blue (#7aa2f7)
RED="\e[38;2;247;118;142m"    # Red (#f7768e)
YELLOW="\e[38;2;224;175;104m" # Orange/Yellow (#e0af68)
GREEN="\e[38;2;158;206;106m"  # Green (#9ece6a)
RESET="\e[0m"                 # Reset to default terminal color

# Define paths
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"
IGNORE_FILE="$REPO_DIR/.syncignore"

# Initialize counters for the summary
diff_count=0
missing_count=0

echo -e "${INFO}Checking for differences between Repo ($REPO_DIR) and Local ($HOME_DIR)...${RESET}"
echo "--------------------------------------------------------------------------------"

cd "$REPO_DIR" || { echo -e "${RED}Failed to cd into $REPO_DIR${RESET}"; exit 1; }

# Using fd: -t f (files), -H (hidden), -I (no-ignore), -E .git (exclude .git), -0 (null-separated)
while IFS= read -r -d '' rel_path; do
    
    # Ignore the script itself and the .syncignore file
    if [[ "$rel_path" == "$(basename "$0")" ]] || [[ "$rel_path" == ".syncignore" ]]; then
        continue
    fi

    # Check if the file matches any pattern in .syncignore
    is_ignored=0
    
    if [[ -f "$IGNORE_FILE" ]]; then
        while IFS= read -r pattern; do
            # Skip empty lines and comments
            [[ -z "$pattern" || "$pattern" == \#* ]] && continue
            
            # Strip trailing slashes from pattern for uniform matching
            pattern="${pattern%/}"

            # Match exact file, or if the file is inside an ignored directory/pattern
            if [[ "$rel_path" == $pattern ]] || \
               [[ "$rel_path" == $pattern/* ]] || \
               [[ "$rel_path" == */$pattern ]] || \
               [[ "$rel_path" == */$pattern/* ]]; then
                is_ignored=1
                break
            fi
        done < "$IGNORE_FILE"
    fi

    # Skip to the next file if it was flagged by .syncignore
    [[ $is_ignored -eq 1 ]] && continue

    local_file="$HOME_DIR/$rel_path"

    # Perform the checks, apply colors to the statuses, and update counters
    if [[ ! -f "$local_file" ]]; then
        echo -e "${RED}Missing locally:${RESET} $rel_path"
        ((missing_count++))
    elif ! cmp -s "$rel_path" "$local_file"; then
        echo -e "${YELLOW}Differs        :${RESET} $rel_path"
        ((diff_count++))
    fi

# The fix: added '--exclude .git' directly to the fd command
done < <(fd --type f --hidden --no-ignore --exclude .git --print0)

echo "--------------------------------------------------------------------------------"

# Print the final colored summary
if [[ $diff_count -eq 0 && $missing_count -eq 0 ]]; then
    echo -e "${GREEN}All files are perfectly in sync!${RESET}"
else
    echo -e "${INFO}Summary:${RESET}"
    [[ $diff_count -gt 0 ]] && echo -e "${YELLOW}• $diff_count file(s) differ${RESET}"
    [[ $missing_count -gt 0 ]] && echo -e "${RED}• $missing_count file(s) missing locally${RESET}"
fi
