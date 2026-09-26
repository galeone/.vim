.vim
====

My .vim folder and .vimrc file: brings autocompletion, highlighting and other handy features for C/C++, Python, Go and other languages.

Plugins are managed by [vim-plug](https://github.com/junegunn/vim-plug) and live in
`plugged/`. Each plugin is also a git submodule of this repo, so the exact plugin
versions are pinned in git history.

### Prerequisites

- A vim compiled with python3 support (`vim --version` should show `+python3`),
  needed by YouCompleteMe. On macOS with MacPorts:

  ```sh
  sudo port install vim +python314
  ```

  (keep the `+python314` variant when upgrading vim, or `+python3` silently goes away)

- Python >= 3.12 for building YouCompleteMe (e.g. MacPorts `python314`)
- `ctags`
- The `black` binary, for auto-formatting python files on save:

  ```sh
  uv tool install black
  ```

### Copy-Paste setup

```sh
cd ~
git clone --recursive git@github.com:galeone/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
cd /usr/include
ctags -f ~/.vim/stdtags -R --c++-kinds=+p --fields=+iaS --extra=+q .
```

Then open vim and run `:PlugInstall`. YouCompleteMe's `do` hook builds it
automatically (takes a few minutes). To build YCM manually instead:

```sh
cd ~/.vim/plugged/YouCompleteMe
# If your device is a low spec device (like a raspberry pi) is better to compile using a single core:
# Just define the env var YCM_CORES=1
./install.py --user --clang-completer --system-libclang --rust-completer --go-completer
```

### Update

```sh
# From inside vim: update all plugins (YCM is rebuilt if it changed), then
# pin the new versions:
:PlugUpdate
git add -A && git commit -m "update plugins"

# Or purely in git (does not run the do hooks):
git submodule update --remote --merge
git add -A && git commit -m "update plugins"
```

`:PlugUpdate` moves each submodule's checkout but doesn't commit it, so the
`git commit` step is what actually records the new plugin versions.
