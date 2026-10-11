# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
# Add bun to path
export PATH="$PATH:$HOME/.bun/bin"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

