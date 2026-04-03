# env
if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

if test -d ~/.local/bin/; then
    export PATH="$PATH:$(realpath ~/.local/bin/)"
fi

if command -v asdf 2>&1 >/dev/null && test -d ~/.asdf/shims/; then
    export PATH="$PATH:$(realpath ~/.asdf/shims/)"
fi

if test -f ~/.dotnet/dotnet; then
    export PATH="$PATH:$(realpath ~/.dotnet/)"
    export DOTNET_ROOT=$(realpath ~/.dotnet/)
fi
if test -d ~/.dotnet/tools/; then
    export PATH="$PATH:$(realpath ~/.dotnet/tools/)"
fi

export HOMEBREW_NO_INSTALL_CLEANUP=1
export LDFLAGS="-L/usr/local/opt/icu4c/lib -L/usr/local/opt/sqlite/lib -L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include -I/usr/local/opt/sqlite/include -I/opt/homebrew/opt/openssl/include"
export EDITOR="code --wait"

if command -v colima &>/dev/null; then
    export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
    export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="${HOME}/.colima/default/docker.sock"
fi

# load aliases
source ~/.aliases

# enable git autocomplete
autoload -Uz compinit
if ! compinit &>/dev/null; then
    rm -f "$HOME/.zcompdump"*
    compinit
fi

# show version control information
autoload -Uz vcs_info
preexec() {
    COMMAND_EXECUTED=1
}
precmd() {
    if [[ $? -ne 0 && $COMMAND_EXECUTED -eq 1 ]]; then
        NEXT_CURSOR="-"
    else
        NEXT_CURSOR="%%"
    fi
    unset COMMAND_EXECUTED
    CLOCK=$(date +%H:%M)
    vcs_info
}
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='${CLOCK} ${PWD/#$HOME/~} ${vcs_info_msg_0_:+$vcs_info_msg_0_ }${NEXT_CURSOR} '

# load keys for ssh agent
if [ ! -S "$SSH_AUTH_SOCK" ] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null || ! pgrep -x ssh-agent >/dev/null 2>&1; then
    test -f ~/.ssh/.env && source ~/.ssh/.env >/dev/null

    if [ ! -S "$SSH_AUTH_SOCK" ] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null || ! pgrep -x ssh-agent >/dev/null 2>&1; then
        echo "Starting ssh-agent..."
        ssh-agent -s >~/.ssh/.env
        chmod 600 ~/.ssh/.env
        source ~/.ssh/.env
        ssh-add ~/.ssh/id_ed25519 ~/.ssh/id_rsa ~/.ssh/work_rsa 2>/dev/null
    fi
fi
