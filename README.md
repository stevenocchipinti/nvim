# (Neo)Vim Config

I'm attempting to use this config for both **Vim** and **Neovim** until I can
settle on which one I prefer. However this config is really setup for Neovim so
there are neovim-specific plugins in here that will need to be removed to work
with standard Vim.

Both version of Vim are easy to install with `brew install neovim vim`.

## Setup for Neovim

1. Clone this repo to `~/.config/nvim`
2. Install plugins: `nvim +PlugInstall +qall`
3. Add `alias vim=nvim` to your shell config

## Setup for Vim

1. Follow instructions above to set it up for **Neovim**
2. Symlink (or copy) these files:

```
ln -s ~/.config/nvim ~/.vim
ln -s ~/.config/nvim/init.vim ~/.vimrc
```

3. Remove any Neovim-specific plugins in `.vimrc`
4. Install plugins: `vim +PlugInstall +qall`
