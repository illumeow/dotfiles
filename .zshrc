# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob nomatch notify
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/student/13/b13902139/.zshrc'

fpath=(~/.zsh/completions $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.config/fzf/fzf_opts.zsh

export BAT_THEME="tokyonight_night"
