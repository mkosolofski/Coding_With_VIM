" Syntax Highlighting
syntax on

" Highlight All Occurrences Of Search Word
set hlsearch

" Highlight line cursor is on
" highlight CursorLine cterm=NONE  ctermbg=darkRed

" Set color scheme
" colorscheme wombat256mod
" colorscheme vividchalk

" Set vim updatetime to 250ms for Vim-GitGutter plugin
set updatetime=250

" Line Numbers
set number

" Case Insensitive Searching
set ic

" Vundle
set nocompatible 
filetype off           
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdtree.git'
Bundle 'joonty/vdebug.git'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-syntastic/syntastic.git'
Bundle 'vim-scripts/taglist.vim.git'
Bundle 'vim-scripts/ctags.vim.git'
Bundle 'tobyS/pdv'
Bundle 'tobyS/vmustache.git'
Bundle 'airblade/vim-gitgutter.git'
Bundle 'craigemery/vim-autotag'
Bundle 'arnaud-lb/vim-php-namespace'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'adoy/vim-php-refactoring-toolbox'

" HTML syntax highlighting
Bundle 'mitsuhiko/vim-jinja.git'

" Bundle 'SirVer/ultisnips.git'
call vundle#end()       
filetype plugin indent on

" Nerd Tree - Shortcuts
map <silent> <C-N> :NERDTree<CR>

" Map Tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Map Tab Switching
nmap tl <C-PageDown>
nmap th <C-PageUp>

" Map Arrow Keys To Split Windows
nmap <silent> <C-S-Right> <c-w>l
nmap <silent> <C-S-Left> <c-w>h
nmap <silent> <C-S-Up> <c-w>k
nmap <silent> <C-S-Down> <c-w>j

" Syntax Checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Taglist - Key Mapping
" nmap <silent> tt :TlistToggle<CR>
" autocmd BufWritePost * :TlistUpdate

" PHP Documentor - Set Template Dir And Map Keys
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nmap <silent> pd :<C-u>silent! call pdv#DocumentWithSnip()<CR>

" Vim-GitGutter
nmap <silent> gd :GitGutterLineHighlightsToggle<CR>

" Highlight matching open/close parentheses, curley braces, etc
" DoMatchParen
set showmatch

" Allow backspacing over anything in insert mode
set backspace=indent,eol,start

" Change window width - greater
nmap <silent> + <C-w>>

" Change window width - smaller
nmap <silent> - <C-w><

" Ctags
let g:autotagTagsFile="ctags.tags"
let g:autotagExcludeSuffixes="png,gif,jpg,ico"
let g:autotagmaxTagsFileSize=1000000000000000000
set tags+=ctags.tags

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" PHP Namespace
let g:php_namespace_sort_after_insert = 1
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" PHP Complete
let g:phpcomplete_parse_docblock_comments = 1
