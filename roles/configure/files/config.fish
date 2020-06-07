# Colored man pages
set -xg PAGER "/usr/bin/most -s"

# Custom Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

command -v lsd > /dev/null && alias ls="lsd --group-dirs first"
command -v lsd > /dev/null && alias tree="lsd --tree --group-dirs first"

command -v bat > /dev/null && alias less='bat'
command -v bat > /dev/null && alias cat='bat --pager=never'

command -v ytop > /dev/null && alias top='ytop --per-cpu'

# To enable starship prompt
starship init fish | source
