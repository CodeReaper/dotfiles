# load brew
if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# add asdf(>=0.16.0) shims to path
if command -v asdf 2>&1 >/dev/null && test -d ~/.asdf/shims/; then
    export PATH="$(realpath ~/.asdf/shims/):$PATH"
fi

# allow for local bin installation
if test -d ~/.local/bin/; then
    export PATH="$PATH:$(realpath ~/.local/bin/)"
fi
if test -d ~/.dotnet/tools/; then
    export PATH="$PATH:$(realpath ~/.dotnet/tools/)"
fi

source ~/.aliases

# enable git autocomplete
autoload -Uz compinit
if ! compinit &>/dev/null; then
  rm -f "$HOME/.zcompdump"*
  compinit
fi

# show version control information
autoload -Uz vcs_info
precmd() {
  if [[ $? -ne 0 ]]; then
    LAST_EXIT="✖"
  else
    LAST_EXIT=""
  fi
  vcs_info
}
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_:+$vcs_info_msg_0_ }${LAST_EXIT:+$LAST_EXIT }%% '

# load keys for ssh agent
# - must use home variable
( # - in a subshell for traps to work
    export SSH_ENV="$HOME/.ssh/.env"
    start_ssh_agent() {
        echo "Starting new ssh-agent..."
        ssh-agent -s > "$SSH_ENV"
        chmod 600 "$SSH_ENV"
        source "$SSH_ENV"

        ssh-add $HOME/.ssh/id_ed25519 2>/dev/null
        ssh-add $HOME/.ssh/id_rsa 2>/dev/null
        ssh-add $HOME/.ssh/work_rsa 2>/dev/null
    }
    trap "rm -f '${SSH_ENV}.lock' || true" EXIT
    if ln ~/.zshrc "${SSH_ENV}.lock" 2> /dev/null; then
        if [ -f "$SSH_ENV" ]; then # really could use a check on whether the ssh-agent process is still running
            source "$SSH_ENV" > /dev/null

            if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
                start_ssh_agent
            fi
        else
            start_ssh_agent
        fi
    else
        sleep 0.3
        [ -f "$SSH_ENV" ] && source "$SSH_ENV" > /dev/null
    fi
    unset SSH_ENV
)
source "$HOME/.ssh/.env" > /dev/null

# env
export HOMEBREW_NO_INSTALL_CLEANUP=1
export LDFLAGS="-L/usr/local/opt/icu4c/lib -L/usr/local/opt/sqlite/lib -L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include -I/usr/local/opt/sqlite/include -I/opt/homebrew/opt/openssl/include"

test -f $HOME/.asdf/plugins/golang/set-env.zsh && source $HOME/.asdf/plugins/golang/set-env.zsh
test -f $HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh && source $HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh

# special cases
if command -v colima &>/dev/null; then
    export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
    export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="${HOME}/.colima/default/docker.sock"
fi
