export PATH="$HOME/.local/share/mise/shims:$PATH"

# GOPATH and binaries
if command -v mise >/dev/null 2>&1; then
  GOPATH="$(mise where go 2>/dev/null || true)"
fi

if [ -n "${GOPATH:-}" ]; then
  export GOPATH
  export PATH="$PATH:$GOPATH/bin"
fi
