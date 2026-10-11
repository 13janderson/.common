export PATH="$PATH:/snap/bin"
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

uv-venv() {
  uv sync
  source .venv/bin/activate
}

if [[ -d ".venv" ]]; then
  echo ".venv detected, activating uv virtual envioronment."
  uv-venv --active
elif [[ -f "uv.lock" ]] && [[ -f "pyproject.toml" ]]; then
  echo "uv.lock and pyproject.toml found not but not .venv."
  uv-venv --active
fi
