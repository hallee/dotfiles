export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export GOPATH="$HOME/Developer/go"

export TERM="xterm-256color"

SAVEHIST=10000000
HISTSIZE=10000000
HISTFILE=~/.zsh_history
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh --history-size=HISTSIZE

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs command_execution_time status background_jobs_joined)
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='black'
POWERLEVEL9K_STATUS_CROSS=true

# ==== Antigen ====
source /opt/homebrew/share/antigen/antigen.zsh
antigen theme bhilburn/powerlevel9k
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# ==== Hub ====
eval "$(hub alias -s)"

# ==== asdf ====
. /opt/homebrew/opt/asdf/libexec/asdf.sh
