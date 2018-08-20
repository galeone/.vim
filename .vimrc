syntax on
set tabstop=4
set cindent shiftwidth=4
set expandtab
set nu
set nocp
set encoding=utf-8
setglobal fileencoding=utf-8

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

" Use pathogen to enabled and install every plugin in the bundle folder
execute pathogen#infect()

" Set filetype=bbcode if file have .bbcode extension
au BufRead,BufNewFile *.bbcode set filetype=bbcode

" Turn on spellchecker if file extension is .md, .txt
au BufRead,BufNewFile *.md set spell spelllang=en_us

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

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
            \ "ReflowComments": "false"}

" ClangFormat command on write
autocmd BufWrite *.cpp,*.cc,*.hpp :ClangFormat
" YAPF format on write
autocmd BufWrite *.py :YAPF

" vim-go, use gofmt -s instead of gofmt
let g:go_fmt_options = { 'gofmt': '-s' }

" omnisharp configuration
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_path = '/opt/omnisharp-roslyn/OmniSharp.exe'
let g:Omnisharp_stop_server = 0  " Do not stop the server on exit
