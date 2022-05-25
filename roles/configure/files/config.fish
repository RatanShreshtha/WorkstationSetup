# Custom Pagers
# set -xg BAT_THEME "OneHalfDark"
set -xg MANROFFOPT "-c"
set -xg MANPAGER "sh -c 'col -bx | bat -l man -p'"
# set -xg GIT_PAGER "bat -l diff -p --style=numbers,changes"

# Custom Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

# Custom Abbreviations
abbr -a '...' 'cd ../..'
abbr -a '....' 'cd ../../..'
abbr -a '.....' 'cd ../../../..'
abbr -a '......' 'cd ../../../../..'
abbr -a '.......' 'cd ../../../../../..'

# Custom Commands
command -v nvim > /dev/null && alias vim="nvim"

command -v lsd > /dev/null && alias ls="lsd --group-dirs first"
command -v lsd > /dev/null && alias tree="lsd --tree --group-dirs first"

command -v bat > /dev/null && alias less='bat'
command -v bat > /dev/null && alias cat='bat --pager=never'

command -v bpytop > /dev/null && alias top='bpytop'

# Custom User Paths
set -U fish_user_paths /home/ratan/.local/bin $fish_user_paths
set -U fish_user_paths /usr/local/opt/openjdk/bin $fish_user_paths
set -U fish_user_paths $HOME/.cargo/env $fish_user_paths

# To enable starship prompt
starship init fish | source
