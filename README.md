Synopsis
========

This repository contains my dotfiles settings for Linux (Ubuntu 16.04 LTS) and Mac OS X(10.12), also a bit FreeBSD (10.0);
See [Windots](https://github.com/HongxuChen/Windots) for Windows settings.

<!-- toc -->

- [LICENSE](#license)
- [Setup](#setup)
- [Package managers](#package-managers)
- [Settings](#settings)
  * [Fundamentals](#fundamentals)
  * [Extras](#extras)
  * [Linux Specific](#linux-specific)
  * [Mac Specific](#mac-specific)
- [Submit an Issue](#submit-an-issue)
- [Bonus](#bonus)

<!-- tocstop -->

LICENSE
=======
[MIT License](https://github.com/HongxuChen/dotfiles/tree/master/LICENSE).

Setup
============

  ```bash
  git clone --recursive git@github.com:HongxuChen/dotfiles.git /path/to/dotfiles
  # or https://github.com/HongxuChen/dotfiles.git
  # my personal dotfiles folder is ~/tools/dotfiles

  ## close other applications for a safe/smooth installation
  cd /path/to/dotfiles

  # see its usage
  ./install.py -h

  # dryrun to see whether there are dangerous operations
  ./install.py -n

  # install (if you're feeling lucky)
  ./install.py

  ```

* Use `install.py` to setup the environment, which merely adds symlinks to `$HOME` directory as well as backups your original settings (if they do exist).
It's better to *dryrun* it beforehand with `install.py -n` (more details with `install.py -h`) to see the effects.
It is suggested to close other applications (e.g., google-chrome, emacs) during setup(especially on Linux).

* Some of my personal information **should be** changed,
you can `grep`or `ag`(see [the\_silver\_searcher](https://github.com/ggreer/the_silver_searcher)) and replace them.

  ```
  # grep my personal info (containing "hongxu") and open in Vi
  git ls-files *[^*.md] | xargs ag 'hongxu' | vi -
  # then you'd change these settings yourself
  ```

* Extra fonts are available [on Dropbox](https://www.dropbox.com/sh/1er7al26qjsjdeg/AACoU5BQ6Ijq_vnBrqLemrRwa?dl=0). Caveats: they are not all free fonts and not under MIT license.

    - can be used by urxvt, etc;
    - note: on Debian derivatives, make sure urxvt is from `rxvt-unicode-256color`;
    - xterm is not recommended as it has poor support for unicode characters.


Package managers
================

Apart from [editors](http://en.wikipedia.org/wiki/Editor_war)' plugin managers (see [below](#fundamentals)), other package managers are used and the lists are inside [misc](https://github.com/HongxuChen/dotfiles/tree/master/misc) directory:

1. **Debian** -- [debian package management](https://www.debian.org/doc/manuals/debian-faq/ch-pkgtools.en.html)

    - linuxbrew frequently causes compilation and linkage errors when buiding tools on your own therefore not recommended

1. **Mac OS X** -- [homebrew](http://brew.sh/)

    - homebrew should be used whenever possible, otherwise it's better to build from source code yourself;
    - use `brew doctor` to see potential issues;
    - `brew cask` is not recommended due to the issues caused by `check for updates` in Mac apps.

1. **Haskell** -- [Stack](https://docs.haskellstack.org/en/stable/README) and [Cabal](https://www.haskell.org/cabal/)

1. **Python** -- [pip/pip3](https://pip.pypa.io/en/latest/)

1. **Ruby** -- [gem](https://rubygems.org/)

1. **Node.js** -- [npm](https://www.npmjs.org/) & [yarn](https://yarnpkg.com/en/)

1. **OCaml** -- [opam](https://opam.ocaml.org/)


Settings
================

Fundamentals
------------

1. **Vim**(managed by [vundle](https://github.com/gmarik/Vundle.vim))(`~/.vimrc`, `~/.vim`)

1. **Emacs**(24+, based on [puremell](https://github.com/purcell/emacs.d)'s settings,
managed by [package.el](http://www.emacswiki.org/emacs/ELPA))(`~/.emacs.d`)

    - start emacs, elisp extensions should be installed automatically for the first time;
    - Configured with [company-mode](http://company-mode.github.io/) and [auto-complete](https://github.com/auto-complete/auto-complete) for completions however the former is preferred;
    - C++ development is fully configured using [rtags](https://github.com/Andersbakken/rtags) (TODO, `homebrew` seems already containing it however depending on a special version of llvm);
    - note: there are some configurations for org and an additional *git submodule* for [reavel.js](https://github.com/hakimel/reveal.js/) for org-reavel(although it's NOT advised to use that)

1. [Zsh](http://www.zsh.org/)(modified from [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh))

    - relevant files:
        - `~/.profile`
        - `~/.aliases`
        - `~/.zshenv`
        - `~/.zprofile`
        - `~/.zshrc`
        - `~/.omz/`

    - `brew install zsh-history-substring-search  zsh-syntax-highlighting` and change login shell (with `chsh`) to zsh to make it really work; enjoy it!


1. [**IPython**](http://ipython.org/)(especially for [sh](http://ipython.org/ipython-doc/dev/interactive/shell.html)/[nb](http://ipython.org/notebook.html) profile)(`~/.ipython/`)

    - for **sh** profile (check command alias: `p_sh`), *lots* of packages are pre-imported(installed via `pip`)
    - ipython-notebook (check command alias: `p_nb`) is based on **sh** profile, a few [extensions](https://github.com/ipython-contrib/IPython-notebook-extensions/wiki) are in `~/.ipython/extensions/`

1. [**sbt**](http://www.scala-sbt.org/)(`~/.sbt`, `~/.sbtrc`)

1. [**pry**](http://pryrepl.org/)(`~/.pryrc`)

    - plugins can be seen at https://github.com/pry/pry/wiki/Available-plugins

1. **git**(`~/.gitconfig`)

    - `_gitignore_global` is available at [misc](https://github.com/HongxuChen/dotfiles/tree/master/misc)
    - [git-extras](https://github.com/tj/git-extras) is awesome

1. [**tmux**](http://tmux.sourceforge.net/)(`~/.tmux.conf`)

Extras
---------

1. [**ack**](http://beyondgrep.com/)(`~/.ackrc`)

    - but prefer `ag` to `ack-grep`

1. [**hg**](http://mercurial.selenic.com/)(aka mercurial) (`~/.hgrc`)
1. [**irb**](http://www.tutorialspoint.com/ruby/interactive_ruby.htm)(`~/.irbrc`)

    - irb also support tab completion, but inferior to pry

1. [**htop**](http://hisham.hm/htop/)

    - `~/config/.htoprc` on Linux
    - `~/.htoprc` on Mac

1. **curl**(`~/.curlrc`)


Linux Specific
--------------

They are *not* exactly linux only, but *I* tend not to use them on Mac OSX. They lie inside [Linux/](https://github.com/HongxuChen/dotfiles/tree/master/Linux) and are also symlinked to `$HOME` by `install.py`. (Ditto for files in [Darwin/](https://github.com/HongxuChen/dotfiles/tree/master/Darwin), which is supposed to be Mac specific.)

- **gdb**(`~/.gdbinit`, `~/.gdb`)

    - gdb is superseded by [lldb](http://lldb.llvm.org) on newer Mac OSX.

- **X11** settings
    - `~/.Xresources`: for XTerm, URxvt, Emacs; should run `xrdb -load ~/.Xresources` firstly
    - `~/.xscreensaver`

- **wget**(~/.wgetrc)
    - since wget is GPL

- **svn**(`~/.subversion/`)
    - Mac has better GUI clients

- **mplayer**(`~/.mplayer`)
    - Mac has better players

- [**Valgrind**](http://valgrind.org/)(`~/.valgrindrc`)

- [**aptitude**](https://wiki.debian.org/Aptitude)(`~/.aptitude/`)

- **bash**(`~/.bashrc`)

    - share `~/.profile`, `~/.aliases` with zsh;
    - used when there's no alternatives.

- [**Freedesktop**](http://www.freedesktop.org/wiki/) configs(`~/.config/`)

    - [**LXDE**](http://lxde.org/)(`autostart/`, `gtk-2.0/`, `gtk-3.0/`, `lxpanel/`, `lxsession/`, `lxterminal/`, `openbox/`, `pcmanfm/`, `user-dirs.dirs`, `user-dirs.locale`)
    - [**Fcitx**](https://fcitx-im.org/wiki/Fcitx)(`fcitx/`)
    - [**Zathura**](https://pwmt.org/projects/zathura/)(`zathura/`)

Mac Specific
------------

- **GVim**(`~/.gvimrc`)

    - for brewed [**MacVim**](https://code.google.com/p/macvim/);
    - Linux Vimers doesn't need GUI :smile:.

- [**slate**](https://github.com/jigish/slate)(`~/.slate`)

Submit an Issue
===============

Report [here](https://github.com/HongxuChen/dotfiles/issues).

Bonus
=====

- You may find that [several awesomeness](https://github.com/sindresorhus/awesome) on github helpful.
