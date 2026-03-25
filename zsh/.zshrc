# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob nomatch notify
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

# path to custom completions
fpath=(~/.zsh/completions $fpath)

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# disable zsh-autocomplete's history menu
bindkey '\e[A' up-line-or-history
bindkey '\eOA' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\eOB' down-line-or-history

source <(fzf --zsh)
source ~/.config/fzf/fzf_opts.zsh

export BAT_THEME="tokyonight_night"

