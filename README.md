DOT-VIM REPOSITORY
==================


Description
-----------

This repo is for my .vim directory.  
It contains my .vimrc and the plugins/scripts I use.  
The plugins are installed with Pathogen to allow easy updating via git.
I have written some bash scripts to automate installing, updating, etc.


How to install this repo
------------------------

    git clone git@github.com:stevenocchipinti/dotvim.git ~/.vim
    ~/.vim/script/init


Adding a new plugin from Github
-------------------------------

    ~/.vim/script/add https://github.com/tpope/vim-fugitive.git

will create a `bundle/vim-fugitive` submodule

    ~/.vim/script/add https://github.com/tpope/vim-fugitive.git fugitive

will create a `bundle/fugitive` submodule


Updating a particular plugin
----------------------------

    ~/.vim/script/update fugitive

Where `fugitive` is the name of the subdirectory under `~/.vim/bundle`

Updating all plugins
--------------------

    ~/.vim/script/update-all


Credit
------

I learned this technique (git submodules) from vimcasts.org  
A full screencast and article is available from here:  
http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
