#!/bin/bash
set -eux

# ================================
# Install Docker, dokcer-compose
# ================================

sudo curl -fsSL https://get.docker.com | sh
# shellcheck disable=SC2046
sudo curl -L https://github.com/docker/compose/releases/download/v2.29.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add docker Group
sudo usermod -aG docker "$USER"


# ================================
# Install Go
# ================================

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# At Upgrade
# go install golang.org/dl/go[version]@latest


# ================================
# Install Go
# ================================
# go: install/update tools
# ※Goは1系では、後方互換性が保証されている
# ※2系では、go2のようにリリースされるらしい
sudo rm -rf /usr/local/go
TAR_FILENAME=$(curl 'https://go.dev/dl/?mode=json' | jq -r '.[0].files[] | select(.os == "linux" and .arch == "amd64" and .kind == "archive") | .filename')
URL="https://go.dev/dl/$TAR_FILENAME"
curl -fsSL "$URL" -o /tmp/go.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
if [[ ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
  export PATH="$PATH:/usr/local/go/bin"
fi
rm -f /tmp/go.tar.gz

# ================================
# Install mise
# ================================

# depend libs in mise
sudo apt install -y unzip bzip2 # ffmpeg depend on gcc nasm yasm

curl https://mise.run | sh

function mise_cmd() {
  ~/.local/bin/mise i -y
  # ~/.local/bin/mise use -gy azure-cli@latest
}

for attempt in {1..3}; do
  if mise_cmd; then
    echo "mise Command succeeded."
    exit 0
  else
    echo "Attempt $attempt failed. Retrying..."
    sleep 5
  fi
done

# create ansible Group
sudo groupadd -g 9010 ansible

# Add ansible Group
sudo usermod -aG ansible "$USER"
