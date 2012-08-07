DOT-VIM REPOSITORY
==================


Description
-----------

This repo is for my .vim directory.
It contains my .vimrc and the plugins/scripts I use.
The plugins are installed with Pathogen to allow easy updating via git.


Credit
------

I learned this technique (git submodules) from vimcasts.org
A full screencast and article is available from here:
http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/


How to install this repo
------------------------

First clone the repository, then run the init script to set up the symlinks

    git clone git@github.com:stevenocchipinti/dotvim.git ~/.vim
    ~/.vim/script/init


To add a new plugin from Github
-------------------------------

By supplying the github url to the add script, it will setup the vim plugin as
a new git submodule, where the name of the submodule will be inferred from the
url (if you don't supply one) and create a new commit

    ~/.vim/script/add <github-url> [<name>]

For example:

    ~/.vim/script/add https://github.com/tpope/vim-fugitive.git

will create a bundle/vim-fugitive submodule, where as this:

    ~/.vim/script/add https://github.com/tpope/vim-fugitive.git fugitive

will create a bundle/fugitive submodule
