#!/bin/bash
set -eux

# go: install/update tools
# ※Goは1系内では後方互換性が保証され、2系ではgo2のようにリリースされるらしい
# ※miseでインストールするとVSCodeがGOROOT,GOPATHを要求され、認識しなくなるため
sudo rm -rf /usr/local/go
TAR_FILENAME=$(curl 'https://go.dev/dl/?mode=json' | jq -r '.[0].files[] | select(.os == "linux" and .arch == "amd64" and .kind == "archive") | .filename')
URL="https://go.dev/dl/$TAR_FILENAME"
curl -fsSL "$URL" -o /tmp/go.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm -f /tmp/go.tar.gz

# golang env
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
if [[ ":$PATH:" != *":$GOROOT/bin:"* ]]; then
  export PATH="$PATH:$GOROOT/bin"
fi
if [[ ":$PATH:" != *":$GOPATH/bin:"* ]]; then
  export PATH=$PATH:$GOPATH/bin
fi

# golangci-lint
# Linter ists: https://golangci-lint.run/usage/linters/
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Go Tools for VSCode
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest
go install github.com/josharian/impl@latest