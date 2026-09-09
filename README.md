# Bihal Neovim Configuration

A portable Neovim configuration for local machines and remote servers.

## Requirements

- Neovim 0.11 or newer
- Git, Make, ripgrep, and unzip
- A C compiler
- Homebrew on macOS, or APT on Debian/Ubuntu

Language servers, formatters, linters, and the Go debugger are installed through Mason on first startup.

## Install

For a reproducible install, use a tagged release instead of executing the moving `main` branch directly:

```bash
git clone --branch <release-tag> --depth 1 https://github.com/SamanKhalife/bihal.git
cd bihal
./bihal.sh
```

To install a specific branch, tag, or commit while running an existing installer:

```bash
BIHAL_REF=<branch-tag-or-commit> ./bihal.sh
```

The installer:

1. Installs the operating-system dependencies.
2. Downloads the requested Bihal revision into a private temporary directory.
3. Backs up an existing Neovim configuration to a timestamped path such as `~/.config/nvim.backup.20260908-120000.12345`.
4. Installs a clean copy in `${XDG_CONFIG_HOME:-$HOME/.config}/nvim`.
5. Restores the previous configuration automatically if replacement fails.

Review scripts before running them, especially scripts that install system packages with `sudo`.

## Dashboard image

The dashboard uses `assets/dashboard.png` by default when `ascii-image-converter` is available.
The installer does not install this optional command automatically. Install it separately, for example:

```bash
go install github.com/TheZoraiz/ascii-image-converter@latest
```

Make sure the directory containing the command (commonly `$HOME/go/bin`) is in `PATH` before starting Neovim.

To override the bundled image, export an absolute or home-relative path before launching Neovim:

```bash
export BIHAL_DASHBOARD_IMAGE="$HOME/path/to/image.jpg"
nvim
```

If Neovim is launched from a GUI, configure the variable in the GUI application's environment instead of only in an interactive shell. When the converter or selected image is unavailable, the dashboard loads normally without the image.

## Default theme

Rose Pine is installed and activated by default. Other configured themes can be selected with `:colorscheme` or the theme picker.
