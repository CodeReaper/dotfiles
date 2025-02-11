# load brew
if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# add asdf(>=0.16.0) shims to path
if command -v asdf 2>&1 >/dev/null; then
    export PATH="$PATH:$(realpath ~/.asdf/shims/)"
fi

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
fi
load() { test -f $1 && ssh-add $1 2> /dev/null }
load ~/.ssh/id_ed25519
load ~/.ssh/id_rsa
load ~/.ssh/work_rsa

# env
export HOMEBREW_NO_INSTALL_CLEANUP=1
export LDFLAGS="-L/usr/local/opt/libffi/lib -L/usr/local/opt/icu4c/lib -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include -I/usr/local/opt/icu4c/include -I/usr/local/opt/sqlite/include"
