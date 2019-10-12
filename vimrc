set nocompatible      " We're running Vim, not Vi!
set encoding=utf-8
syntax enable
filetype off           " Enable filetype detection

let g:rust_recommended_style = 0

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'DataWraith/auto_mkdir'
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'mattn/webapi-vim'
" Emmet
" Plugin 'mattn/emmet-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'eagletmt/neco-ghc'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'Shougo/vimproc'
Plugin 'dag/vim-fish'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-rails'
" Plugin 'tpope/vim-bundler'
Plugin 'vim-ruby/vim-ruby'
Plugin 'rhysd/vim-crystal'
Plugin 'kchmck/vim-coffee-script'
Plugin 'posva/vim-vue'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'janko-m/vim-test'
Plugin 'ngmy/vim-rubocop'
" Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
" Plugin 'mattn/gist-vim'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-markdown'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'reedes/vim-pencil'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'thoughtbot/vim-rspec'
" GPG support
Plugin 'jamessan/vim-gnupg'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leshill/vim-json'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-haml'
" Plugin 'tpope/vim-heroku'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'valloric/YouCompleteMe'
Plugin 'rkennedy/vim-delphi'
Plugin 'vim-latex/vim-latex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
Plugin 'hwartig/vim-seeing-is-believing'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set tabstop=2 shiftwidth=2 expandtab
set backspace=indent,eol,start
" set modeline
set ls=2
" set rnu
set number
highlight LineNr ctermfg=darkred
set nowrap
" let g:session_autosave='yes'

" Test Suite key mappings
" MiniTest
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>m :Minitest<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
" RSpec
map <leader>r :call RunAllSpecs()<CR>
map <Leader>f :call RunCurrentSpecFile()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>p :call RunLastSpec()<CR>
" Custom
nmap <silent> <leader>b :!bundle<CR>
nmap <silent> <leader>q :w !write-well %<CR>
nmap <silent> <leader>e :w !mdspell -r -n -a --en-us %<CR>
nmap <silent> <leader>c :w !clear<CR>

" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  autocmd!

  autocmd FileType ruby nmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)
  autocmd FileType ruby xmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)

  autocmd FileType ruby nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby imap <buffer> <F4> <Plug>(seeing-is-believing-mark)

  autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
  autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing-is-believing-run)
augroup END

autocmd BufRead,BufNewFile *.es6 setfiletype javascript

autocmd FileType c,cpp,js,coffee,vue,rb,jsx,css,scss,yml,haml,slim,rs autocmd BufWritePre <buffer> %s/\s\+$//e

"if $COLORTERM == 'gnome-terminal'
"  set t_Co=256
"endif

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" let g:airline#extensions#ale#enabled = 1

" Haskell
nnoremap <Leader>ht :GhcModType<cr>
nnoremap <Leader>htc :GhcModTypeClear<cr>

set hidden
let g:racer_cmd = $HOME . "/bin/racer"
let $RUST_SRC_PATH = $HOME . "/.cargo/bin"

let g:ycm_key_list_select_completion = ['<Down>'] " Remove <Tab> from the list of keys mapped by YCM.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "ᐅ"

let g:ycm_semantic_triggers = {'haskell' : ['.']}

let g:syntastic_ruby_rubocop_exec = system("which rubocop")

let g:ale_fixers = ['prettier', 'eslint']

set shell=/bin/bash
let s:comment_map = {}
let s:comment_map["c"] = '\/\/'
let s:comment_map["cpp"] = '\/\/'
let s:comment_map["go"] = '\/\/'
let s:comment_map["java"] = '\/\/'
let s:comment_map["javascript"] = '\/\/'
let s:comment_map["javascript.jsx"] = '\/\/'
let s:comment_map["lua"] = '--'
let s:comment_map["scala"] = '\/\/'
let s:comment_map["php"] = '\/\/'
let s:comment_map["python"] = '#'
let s:comment_map["ruby"] = '#'
let s:comment_map["rust"] = '\/\/'
let s:comment_map["sh"] = '#'
let s:comment_map["desktop"] = '#'
let s:comment_map["fstab"] = '#'
let s:comment_map["conf"] = '#'
let s:comment_map["profile"] = '#'
let s:comment_map["bashrc"] = '#'
let s:comment_map["bash_profile"] = '#'
let s:comment_map["mail"] = '>'
let s:comment_map["eml"] = '>'
let s:comment_map["bat"] = 'REM'
let s:comment_map["ahk"] = ';'
let s:comment_map["vim"] = '"'
let s:comment_map["tex"] = '%'

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " "
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction


nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>
