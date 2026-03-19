# ~/.fzf_opts.zsh
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# --- 1. Fast Search Engine (using 'fd') ---
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd for **<TAB> path completion
_fzf_compgen_path() { fd --hidden --follow --exclude .git . "$1" }
_fzf_compgen_dir()  { fd --type=d --hidden --follow --exclude .git . "$1" }

# --- 2. Visual Previews & Advanced Styling (Tokyo Night Theme) ---
# Set the layout, preview window size, Ctrl+/ toggle, and full box styling
export FZF_DEFAULT_OPTS="
  --layout=reverse --preview-window=right:60%
  --style full --border --padding 1,2
  --border-label ' Search ' --input-label ' Input ' --header-label ' File Type '
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --bind 'result:transform-list-label:if [[ -z \$FZF_QUERY ]]; then echo \" \$FZF_MATCH_COUNT items \"; else echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"; fi'
  --bind 'focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}'
  --bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"'
  --bind 'ctrl-r:change-list-label( Reloading... )+reload(eval \$FZF_DEFAULT_COMMAND)'
  --color='fg:#c0caf5,bg:#16161e,hl:#9ece6a'
  --color='fg+:#ffffff,bg+:#283457,hl+:#7aa2f7'
  --color='info:#545c7e,prompt:#7dcfff,pointer:#7dcfff'
  --color='marker:#9ece6a,spinner:#9ece6a,header:#7aa2f7'
  --color='border:#565f89,label:#c0caf5'
  --color='preview-border:#bb9af7,preview-label:#bb9af7'
  --color='list-border:#9ece6a,list-label:#9ece6a'
  --color='input-border:#f7768e,input-label:#f7768e'
  --color='header-border:#7aa2f7,header-label:#7dcfff'
"

# Set default previews for files (Ctrl+T) and directories (Alt+C)
alias fzf="fzf --preview '~/.config/fzf/fzf_preview.sh {}'"
export FZF_CTRL_T_OPTS="--preview '~/.config/fzf/fzf_preview.sh {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# --- 3. Smart Command Completion ---
# Changes the preview based on the command you are running
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd|tree)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# --- 4. Aliases ---
# Fast Neovim fuzzy-find: type 'fv', find your file, hit Enter to open in Neovim
# alias fv='nvim $(fzf --preview="bat -n --color=always {}")'
fv() {
  # 1. Capture the selection from fzf
  local selection
  selection=$(fzf --preview "~/.config/fzf/fzf_preview.sh {}")

  # 2. Check if the user actually picked something (avoids errors on Esc)
  if [[ -n "$selection" ]]; then
    # 3. Change directory to the file's parent folder
    cd "$(dirname "$selection")" || return
    # 4. Open the file in Neovim (using basename since we are now in the folder)
    nvim "$(basename "$selection")"
  fi
}

fcd() {
  local dir=$(fd --type d --hidden --exclude .git . ${1:-.} | fzf --preview 'eza --tree --color=always {} | head -20')
  [ -n "$dir" ] && cd "$dir"
}
