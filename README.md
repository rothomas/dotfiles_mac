# rothomas/dotfiles_mac
My dotfiles, pared down macOS edition.
Unlike my older dotfiles repo this one does not attempt to install software in the chezmoi scripts.

# Applying

Install [chezmoi](https://chezmoi.io) using [Homebrew](https://brew.sh).

```shell
brew install chezmoi
```

Set up your local dotfiles using this repo:

```shell
chezmoi init --apply https://github.com/rothomas/dotfiles_mac
```


