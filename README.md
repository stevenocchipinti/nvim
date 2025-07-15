# Dotfiles

This repo used to _just_ contain my Neovim config, however I've decided to merge
this with the rest of my dotfiles to simplify things.

I'm also trying out `chezmoi` to manage this, see the [chezmoi
docs](https://www.chezmoi.io/) for more information

## Installing dotfiles

```bash
git clone git@github.com:stevenocchipinti/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup_mac.sh
```

## Installing JUST the Neovim config

As this repo used to be just for Neovim, here is how you can achieve the same
thing.

```bash
brew install neovim
git clone git@github.com:stevenocchipinti/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/home/dot_config/nvim ~/.config/nvim
alias vim=nvim
```

## LazyVim

This repo used used to include my own basic Vim config (started in 2011), which
then migrated to Neovim and is now based on
[LazyVim](https://github.com/LazyVim/LazyVim) (as of e8d11b8).

Checkout the [LazyVim docs](https://www.lazyvim.org/) for more information on
how to use it, as it includes many pre-configured plugins, options and keybinds.
