syntax on
set tabstop=4
set cindent shiftwidth=4
set expandtab
set nu
set nocp
set encoding=utf-8
setglobal fileencoding=utf-8

if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        set backspace=indent,eol,start
    endif
endif

" map autocompletion (C-n) to ctrl + space
if has("gui_running")
" C-space works in gvim both in windows & linux
    inoremap <C-Space> <C-n>
else "no gui
    if has("unix")
        inoremap <Nul> <C-n>
    endif
endif

"switch to paste mode with F2
set pastetoggle=<F2>

" runtimepath
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" enable filetype plugin and indent
filetype plugin indent on

" vim latex suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" Use vim-plug to install plugins (kept in this repo as git submodules)
call plug#begin('~/.vim/plugged')
Plug 'rhysd/vim-clang-format'
Plug 'jansenm/vim-cmake'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'maksimr/vim-jsbeautify'
Plug 'galeone/vim-pi-chat'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --rust-completer --go-completer' }
Plug 'psf/black'
call plug#end()

" Set filetype=bbcode if file have .bbcode extension
au BufRead,BufNewFile *.bbcode set filetype=bbcode

" Turn on spellchecker if file extension is .md, .txt
au BufRead,BufNewFile *.md set spell spelllang=en_us

let g:ycm_global_ycm_extra_conf = expand('$HOME/.vim/.ycm_extra_conf.py')
let g:ycm_confirm_extra_conf = 0
"let g:ycm_python_binary_path = 'python'
"let g:ycm_filetype_blacklist = {'go': 1}

" https://stackoverflow.com/questions/6514800/vim-auto-completion-for-cs-include-clause
map <C-L> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
set tags=~/.vim/stdtags,tags,.tags,../tags
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup",
            \ "ReflowComments": "false",
            \ "SortIncludes": "true"}

" ClangFormat command on write
"autocmd BufWrite *.cpp,*.cc,*.hpp,*.proto :ClangFormat

" vim-go, use gofmt -s instead of gofmt
let g:go_fmt_options = { 'gofmt': '-s' }

" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" rust
let g:rustfmt_autosave = 1
" black: format python files on save
" (the psf/black :Black command needs a +python3 vim, so call the binary directly)
function! FormatWithBlack()
    if !executable('black')
        return
    endif
    let l:prev_swap = &swapfile
    setlocal noswapfile
    write
    let l:ret = system('black -q ' . shellescape(expand('%:p')))
    if v:shell_error == 0
        silent edit!
    else
        echohl ErrorMsg | echo l:ret | echohl None
    endif
    let &swapfile = l:prev_swap
endfunction
autocmd BufWritePre *.py call FormatWithBlack()
" vim-pi-chat
let g:pi_chat_width = 0.4    " chat panel = 40% of the window width
