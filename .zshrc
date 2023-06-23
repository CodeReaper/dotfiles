# load brew
brew=/opt/homebrew/bin/brew
test -x $brew || brew=/usr/local/bin/brew
eval "$($brew shellenv)"

# load asdf
asdf=$(brew --prefix asdf)/asdf.sh
test -d $asdf || asdf=$(brew --prefix asdf)/libexec/asdf.sh
source $asdf

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
    load() { test -f $1 && ssh-add $1 }
    eval `ssh-agent -s`
    load ~/.ssh/id_ed25519
    load ~/.ssh/id_rsa
    load ~/.ssh/work_rsa
fi

# env
export HOMEBREW_NO_INSTALL_CLEANUP=1
export LDFLAGS="-L/usr/local/opt/libffi/lib -L/usr/local/opt/icu4c/lib -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include -I/usr/local/opt/icu4c/include -I/usr/local/opt/sqlite/include"
