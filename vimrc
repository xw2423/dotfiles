let mapleader = ','
let g:mapleader = ','
let g:isgvim = has('win32') && has('gui_win32') && has('gui_running')

" vim root
if g:isgvim
    let $VIMROOT=$HOME.'/_dotfiles'
    source $VIMROOT/autoload/plug.vim
else
    let $VIMROOT=$HOME.'/.dotfiles'
endif

"load plugins
if filereadable($VIMROOT.'/vimrc.plug')
    source $VIMROOT/vimrc.plug
endif

" if filereadable($HOME .'/'.g:vimroot.'/vimrc.plug')
    " exec 'source ' . $HOME . '/' . g:vimroot .'/vimrc.plug'
" endif

"======================================================
" Base Configure
"======================================================
" encoding dectection
set enc=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set helplang=en
set termencoding=utf-8

filetype plugin indent on
syntax on

set shell=bash
set background=dark
set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "

"" Turn on the WiLd menu
set wildmenu
set wildignore=**.o,*~,.swp,*.bak,*.pyc,*.class

" highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" search
set incsearch
set ignorecase
set smartcase
set hlsearch    " highlight search terms
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" editor settings
set history=1000
set nocompatible
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set report=0                                                      " always report number of lines changed                "
set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
set title                                                         " show file in titlebar
set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
set matchpairs+=<:>                                               " specially for html
set viewoptions=folds,options,cursor,unix,slash                   " better unix / windows compatibility
set shortmess+=filmnrxoOtT                                        " abbrev. of messages (avoids 'hit enter')
set hidden                                                        " allow buffer switching without saving
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.                     " Highlight problematic whitespace
set splitbelow
set novisualbell noerrorbells                                     " don't beep
set nostartofline                                                 " keep cursor postion when switching between buffers
set wildmode=longest:full,full
set pastetoggle=<F2>
set mouse=""
set nobackup

" folder
set foldenable        " code folding
set foldmethod=indent " options: manual, indent, expr, syntax, diff, marker
set foldlevel=99

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Default Indentation
set autoindent
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
set expandtab       " expand tab to space
autocmd FileType html,xhtml,javascript,sass,scss,css,json,xml setlocal tabstop=2 shiftwidth=2 softtabstop=2

" syntax support
autocmd Syntax javascript set syntax=jquery   " JQuery syntax support
" js
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" vue
au BufRead,BufNewFile *.vue set filetype=html
" reset php iskeyword
au FileType php setlocal isk=@,48-57,_,127-255
" conf
if !did_filetype()
    au BufNewFile,BufRead *.conf set ft=conf
endif

"ctags
set tags=./tags;/,~/.vimtags

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

"======================================================
" Key Mapping
"======================================================
" easier navigation between split windows
nnoremap <c-j> <c-w>j<c-w>_
nnoremap <c-k> <c-w>k<c-w>_
nnoremap <c-h> <c-w>h<c-w>_
nnoremap <c-l> <c-w>l<c-w>_

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

"Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
noremap Y y$
" Go to home and end using capitalized directions
noremap H 0
noremap L $

"search
nnoremap gd #*

" delete to black hole register, not going to clipboard etc
nnoremap <leader>D "_D
nnoremap <leader>dd "_dd
vnoremap <leader>d "_d
nnoremap <leader>x "_x
nnoremap <leader>X "_X
vnoremap <leader>x "_x

"exchange line
nnoremap <leader>j ddp
nnoremap <leader>k ddkP
vnoremap <leader>j xp`[V`]
vnoremap <leader>k xkP`[V`]

" Bash like keys for the command  & insert
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-B> <Left>
cnoremap <C-F> <RIGHT>
cnoremap <C-H> <Backspace>
cnoremap <C-D> <Delete>

" simple surround
vnoremap " S"
vnoremap ' S'
vnoremap ` S`
vnoremap [ S[
vnoremap ( S(
vnoremap { S{
vnoremap } S}
vnoremap ] S]
vnoremap ) S)

" switch tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>
noremap <leader>tt :tabnew<CR>
noremap <leader>tm :tabmove<CR>
noremap <tab> :tabn<CR>
noremap <s-tab> :tabp<CR>
" record current tab no to return prev tab when closed
au TabLeave * let g:prev_tab_no=tabpagenr()-1
noremap <leader>g :tabc<CR>:exec g:prev_tab_no"tabn"<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"======================================================
" GUI
"======================================================
if has("gui_running")
    set mouse=a
    set go=aAce
    set guifont=Monaco:h13
    set showtabline=2
    set columns=140
    set lines=40
    noremap <D-M-Left> :tabprevious<cr>
    noremap <D-M-Right> :tabnext<cr>
    colo torte
    set langmenu=zh_CN.UTF-8
    source $VIMRUNTIME/delmenu.vim
endif

"======================================================
" cscope
"======================================================
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"load local settings
if filereadable(expand("~/.dotfiles/vimrc.local"))
  source ~/.dotfiles/vimrc.local
endif
