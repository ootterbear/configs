# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Load Homebrew's shell environment for interactive shells too, so completions
# from /opt/homebrew/share/zsh/site-functions are available before compinit.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Override Homebrew's legacy docker completion with Docker CLI's generated one.
if command -v docker >/dev/null 2>&1; then
  eval "$(docker completion zsh)"
fi

# Local bin env & PATH
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# Claude launcher
source ~/.claude-launcher.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Codex launchers
alias co='codex --no-alt-screen -C "$PWD"'
alias cor='codex resume --last --no-alt-screen'

alias ll='ls -alF'
alias tat='tmux a -t'

# Machine-specific settings (AWS/EKS profiles etc.) — not tracked in this repo
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Claude Code OpenTelemetry → local collector (~/infra docker compose)
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317

# Hermes Agent → 같은 collector, 단 OTLP/HTTP :4318 + 별도 service.name.
# Claude Code의 gRPC :4317 설정과 충돌하지 않도록 함수 스코프에서만 swap.
# `hermes` 바이너리의 모든 서브커맨드(setup/model/gateway/plugins/...)에 그대로 적용됨.
hermes() {
  # macOS env는 -u 플래그가 VAR=value 할당보다 반드시 먼저 와야 함.
  env \
    -u CLAUDE_CODE_ENABLE_TELEMETRY \
    OTEL_SERVICE_NAME="hermes-agent" \
    OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf" \
    OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4318" \
    OTEL_TRACES_EXPORTER="otlp" \
    OTEL_METRICS_EXPORTER="otlp" \
    OTEL_LOGS_EXPORTER="otlp" \
    OTEL_RESOURCE_ATTRIBUTES="deployment.environment=local,host.name=$(hostname)" \
    OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="cumulative" \
    command hermes "$@"
}

# Hermes를 OTel 없이 돌리고 싶을 때 (디버깅/오프라인)
hermes-noobs() {
  env \
    -u OTEL_SERVICE_NAME \
    -u OTEL_EXPORTER_OTLP_PROTOCOL \
    -u OTEL_EXPORTER_OTLP_ENDPOINT \
    -u OTEL_TRACES_EXPORTER \
    -u OTEL_METRICS_EXPORTER \
    -u OTEL_LOGS_EXPORTER \
    -u OTEL_RESOURCE_ATTRIBUTES \
    -u OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE \
    -u CLAUDE_CODE_ENABLE_TELEMETRY \
    command hermes "$@"
}

# 현재 hermes에 적용될 OTel env를 미리 확인
hermes-otel-env() {
  echo "Service:      hermes-agent"
  echo "Protocol:     http/protobuf"
  echo "Endpoint:     http://localhost:4318"
  echo "Resource:     deployment.environment=local,host.name=$(hostname)"
  echo "Temporality:  cumulative (Prometheus 호환)"
  echo "ClaudeCode:   비활성 (CLAUDE_CODE_ENABLE_TELEMETRY unset)"
}
