" Syntax Highlighting
syntax on

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
Bundle 'scrooloose/syntastic.git'
Bundle 'vim-scripts/taglist.vim.git'
Bundle 'vim-scripts/ctags.vim.git'
Bundle 'tobyS/pdv.git'
Bundle 'tobyS/vmustache.git'
Bundle 'SirVer/ultisnips.git'
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
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" Syntax Checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Taglist - Key Mapping
nmap <silent> <C-T> :TlistToggle<CR>

" PHP Documentor - Set Template Dir And Map Keys
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nmap <silent> pd :<C-u>silent! call pdv#DocumentWithSnip()<CR>
