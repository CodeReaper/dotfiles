eval "$(/usr/local/bin/brew shellenv)"
source $(brew --prefix asdf)/asdf.sh

source ~/.aliases

# enable git autocomplete
autoload -Uz compinit && compinit -u

# show version control information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_} %% '

# load keys for ssh agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/work_rsa
fi

# env
export HOMEBREW_NO_INSTALL_CLEANUP=1
export LDFLAGS="-L/usr/local/opt/libffi/lib -L/usr/local/opt/icu4c/lib -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include -I/usr/local/opt/icu4c/include -I/usr/local/opt/sqlite/include"
