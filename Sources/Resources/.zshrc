export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export TERM="xterm-256color"

SAVEHIST=10000000
HISTSIZE=10000000
HISTFILE=~/.zsh_history

# ==== Hub ====
eval "$(hub alias -s)"

# ==== asdf ====
. $(brew --prefix asdf)/asdf.sh

# ==== zinit ====
source $(brew --prefix)/opt/zinit/zinit.zsh
zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions # suggestions and tab-completion for commands
zinit light zsh-users/zsh-syntax-highlighting
zinit light MichaelAquilina/zsh-auto-notify # notifications for long-running commands
zinit pack"default+keys" for fzf # fuzzy find for CTRL-R history

# ==== Powerlevel10k ====
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs command_execution_time status background_jobs_joined)
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='black'
POWERLEVEL9K_STATUS_CROSS=true
