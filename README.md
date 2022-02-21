.vim
====

My .vim folder and .vimrc file: brings autocompletion, highlighting and other handy features for C/C++, Python, Go and other languages.

### Copy-Paste setup

```sh
cd ~
git clone --recursive git@github.com:galeone/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
cd /usr/include
ctags -f ~/.vim/stdtags -R --c++-kinds=+p --fields=+iaS --extra=+q .

# On Archlinux is better using system-libclang
cd ~/.vim/bundle/YouCompleteMe
# If your device is a low spec device (like a raspberry pi) is better to compile using a single core:
# Just define the env var YCM_CORES=1
./install.py --clang-completer --system-libclang --rust-completer --go-completer
```

### C++ projects

The C++ projects that use CMake (and thus can't work easily with the default YCM set of flags) must run cmake first and generate the `compilation_database.json` file, then copy the `.ycm_extra_conf.py` file into the project root in order to have
the right suggestions for sources that are not in the standard library.

### Update

Copy paste version of submodule update command and sync.

```
for s in $(git submodule | awk '{print $2}' |grep -v black); do
    cd $s
    git clean -fdx
    git submodule foreach 'git clean -fdx'
    git checkout master
    git pull origin master
    git submodule sync --recursive
    git submodule update --init --recursive
    cd -
done
cd bundle/black; git checkout main; git pull origin main
cd -
```
