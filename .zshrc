PATH=$PATH:~/Library/Python/3.7/bin

WORDCHARS=${WORDCHARS/\/}

autoload -U compinit colors vcs_info
colors
compinit
precmd() { vcs_info }


zmodload zsh/complete
zmodload zsh/computil
zmodload zsh/complist


# Report command running time if it is more than 3 seconds
REPORTTIME=3
# Keep a lot of history
HISTFILE=~/.zhistory
HISTSIZE=20000
SAVEHIST=25000
# Add commands to history as they are entered, don't wait for shell to exit
setopt INC_APPEND_HISTORY
# Also remember command start time and duration
setopt EXTENDED_HISTORY
# Do not keep duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS

alias ems=/Applications/Emacs.app/Contents/MacOS/Emacs
alias em='/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_14/emacsclient -n'
alias ls='ls -Gh'

setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats ' git(%b)'
local returncode="%(?..%{$fg[red]%} %? ↵%{$reset_color%})"

PROMPT='[$(date +%H:%M:%S)] %S${HOST}%{$reset_color%}@%1d$vcs_info_msg_0_$returncode %# '
