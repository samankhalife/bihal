# Bihal Neovim Configuration

My personal Neovim configuration for local machines and remote servers.

## Install

```bash
bash <(curl -Ls https://raw.githubusercontent.com/SamanKhalife/bihal/main/bihal.sh)
```

Requires Neovim 0.11 or newer. If an existing Neovim configuration is found, the installer backs it up before installing Bihal.

Language servers, formatters, linters, and the Go debugger are installed automatically through Mason on first startup.

## Dashboard image

The dashboard uses [assets/dashboard.png](assets/dashboard.png) by default. To display it, install `ascii-image-converter`:

```bash
go install github.com/TheZoraiz/ascii-image-converter@latest
```

To use your own image:

```bash
export BIHAL_DASHBOARD_IMAGE="$HOME/path/to/image.jpg"
nvim
```

Add the `export` command to `.zshrc` or `.bashrc` to keep it enabled.

## Theme

Rose Pine is enabled by default. Use `<leader>th` to choose another theme.
