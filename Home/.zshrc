export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"
export GOPATH="$HOME/Code/go"
export TERM="xterm-256color"

SAVEHIST=4000
HISTSIZE=400
HISTFILE=~/.zsh_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh --history-size=400

# ==== Empty the iTerm title bar ====
echo -e -n "\033]; \007" 

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs command_execution_time status background_jobs_joined)
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='black'
POWERLEVEL9K_STATUS_CROSS=true

# ==== Antigen ====
source /usr/local/share/antigen/antigen.zsh
antigen theme bhilburn/powerlevel9k
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# ==== Hub ====
eval "$(hub alias -s)"
