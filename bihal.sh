#!/usr/bin/env bash

set -euo pipefail

readonly REPO_URL="https://github.com/SamanKhalife/bihal.git"
readonly BIHAL_REF="${BIHAL_REF:-main}"
readonly DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

TEMP_DIR=""
STAGING_DIR=""
BACKUP_DIR=""
INSTALL_COMPLETE=false

cleanup() {
  local exit_code=$?

  if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
    rm -rf -- "$TEMP_DIR"
  fi

  if [[ -n "$STAGING_DIR" && -d "$STAGING_DIR" ]]; then
    rm -rf -- "$STAGING_DIR"
  fi

  if [[ "$INSTALL_COMPLETE" != true && -n "$BACKUP_DIR" && -e "$BACKUP_DIR" && ! -e "$DEST_DIR" ]]; then
    echo "Installation failed. Restoring the previous Neovim configuration..." >&2
    mv -- "$BACKUP_DIR" "$DEST_DIR"
  fi

  exit "$exit_code"
}
trap cleanup EXIT INT TERM

install_debian() {
  echo "Detected Debian-based system."
  echo "Adding the Neovim PPA and installing dependencies..."
  sudo apt update
  sudo apt install -y software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/unstable -y
  sudo apt update
  sudo apt install -y make gcc ripgrep unzip git xclip neovim
}

install_macos() {
  echo "Detected macOS."
  echo "Updating Homebrew and installing dependencies..."
  brew update
  brew install make gcc ripgrep unzip git neovim
}

install_dependencies() {
  case "${OSTYPE:-}" in
    linux-gnu*)
      if command -v apt >/dev/null 2>&1; then
        install_debian
      else
        echo "Unsupported Linux distribution. Install the required dependencies manually." >&2
        exit 1
      fi
      ;;
    darwin*)
      if command -v brew >/dev/null 2>&1; then
        install_macos
      else
        echo "Homebrew was not found. Install Homebrew first." >&2
        exit 1
      fi
      ;;
    *)
      echo "Unsupported operating system: ${OSTYPE:-unknown}" >&2
      exit 1
      ;;
  esac
}

verify_dependencies() {
  local missing=()
  local command_name

  for command_name in git make rg unzip nvim; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
      missing+=("$command_name")
    fi
  done

  if (( ${#missing[@]} > 0 )); then
    printf 'Missing required commands: %s\n' "${missing[*]}" >&2
    exit 1
  fi

  if ! nvim --headless "+if !has('nvim-0.11') | cquit 1 | endif" +qa >/dev/null 2>&1; then
    echo "Bihal requires Neovim 0.11 or newer." >&2
    exit 1
  fi
}

clone_configuration() {
  TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/bihal.XXXXXX")"
  local repo_dir="$TEMP_DIR/repo"

  echo "Fetching Bihal revision: $BIHAL_REF"
  git init -q "$repo_dir"
  git -C "$repo_dir" remote add origin "$REPO_URL"
  git -C "$repo_dir" fetch --depth 1 origin "$BIHAL_REF"
  git -C "$repo_dir" checkout -q --detach FETCH_HEAD
}

install_configuration() {
  local config_parent
  config_parent="$(dirname "$DEST_DIR")"
  mkdir -p -- "$config_parent"

  STAGING_DIR="$(mktemp -d "$config_parent/.nvim.install.XXXXXX")"
  cp -p "$TEMP_DIR/repo/init.lua" "$TEMP_DIR/repo/lazy-lock.json" "$STAGING_DIR/"
  cp -R -p "$TEMP_DIR/repo/lua" "$STAGING_DIR/"
  if [[ -d "$TEMP_DIR/repo/assets" ]]; then
    cp -R -p "$TEMP_DIR/repo/assets" "$STAGING_DIR/"
  fi
  if [[ -f "$TEMP_DIR/repo/.stylua.toml" ]]; then
    cp -p "$TEMP_DIR/repo/.stylua.toml" "$STAGING_DIR/"
  fi

  if [[ -e "$DEST_DIR" || -L "$DEST_DIR" ]]; then
    BACKUP_DIR="${DEST_DIR}.backup.$(date +%Y%m%d-%H%M%S).$$"
    echo "Backing up the existing configuration to $BACKUP_DIR"
    mv -- "$DEST_DIR" "$BACKUP_DIR"
  fi

  mv -- "$STAGING_DIR" "$DEST_DIR"
  STAGING_DIR=""
  INSTALL_COMPLETE=true
}

main() {
  install_dependencies
  verify_dependencies
  clone_configuration
  install_configuration

  echo "Neovim and the Bihal configuration were installed successfully."
  if [[ -n "$BACKUP_DIR" ]]; then
    echo "Previous configuration backup: $BACKUP_DIR"
  fi
}

main "$@"
