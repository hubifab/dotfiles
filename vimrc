set nocompatible              " be iMproved, required
filetype off                  " required
scriptencoding utf-8
set encoding=utf-8
set t_Co=256

" set the runtime path to include Vundle and initialize
" install Vundle: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/itchyny/lightline.vim'
Plugin 'https://github.com/vim-syntastic/syntastic.git'
Plugin 'https://github.com/tpope/vim-commentary.git'
Plugin 'https://github.com/xtal8/traces.vim'
Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plugin 'https://github.com/vim-scripts/indentpython.vim.git'
Plugin 'https://github.com/dhruvasagar/vim-table-mode'
Plugin 'https://github.com/gabrielelana/vim-markdown'
" ==== THEMES ====
Plugin 'https://github.com/fneu/breezy.git'

call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set wildmenu
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

" Get off my lawn
" nnoremap <Left> :echoe "Use h!"<CR>
" nnoremap <Right> :echoe "Use l!"<CR>
" nnoremap <Up> :echoe "Use k!"<CR>
" nnoremap <Down> :echoe "Use j!"<CR>

" insert current date
nnoremap <Leader>d :pu=strftime('%Y-%m-%d')<CR>

" insert current time
nnoremap <Leader>t :pu=strftime('%H:%M')<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Toggle Table Mode
" start with | ... | ; next line type || ; [| and ]| to jump between cols
nnoremap <Leader>tm :ToggleTableMode<space>

" execute/run current line as vim command
nnoremap <Leader>cm yy:@"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" reset last search
nnoremap <silent> ,<space> :nohlsearch<CR>

" set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

set number
set numberwidth=5
set number relativenumber
set nonumber norelativenumber  " turn hybrid line numbers off
"set !number !relativenumber    " toggle hybrid line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set number
augroup END

" make sure folded code blocks are retained after files are closed
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

map <C-n> :NERDTreeToggle<CR>
map <C-s> :SyntasticToggleMode<CR>
" Can be typed even faster than jj.
imap jk <Esc>

" indentation and line switching with space-hjkl
nnoremap <Leader>l >> 
nnoremap <Leader>h <<
nnoremap <Leader>j ddp
nnoremap <Leader>k ddkP

set nowrap
set hls!
set ai
set ignorecase
highlight Normal ctermbg=black ctermfg=white
highlight iCursor guifg=white guibg=steelblue
set cursorline

if version >= 800         " only set termguicolors when vim version is 8 or greater 
    set termguicolors
endif

if has("gui_running")
  echo "GUI is running"
  set background=light
  let g:lightline = {
    \ 'colorscheme': 'breezy',
    \ }
  if has("macunix")
    set guifont=Monaco:h11
  else
    set guifont=Monospace\ 12
  endif
else
  if has("macunix")
    let g:lightline = {
      \ 'colorscheme': 'breezy',
      \ }
    " change keyboard layout
    command Lus silent exec "!issw com.apple.keylayout.US" | redraw!
    command Lde silent exec "!issw com.apple.keylayout.German" | redraw!
  else " probably ubuntu or raspbian
    set background=light
    let g:lightline = {
      \ 'colorscheme': 'breezy',
      \ }
    " change keyboard layout (ubuntu)
    command Lus silent exec "!setxkbmap us" | redraw!
    command Lde silent exec "!setxkbmap de" | redraw!
  endif
endif

" set colorscheme (256 colors):
colorscheme afterglow

" setup colors for normal text and comments
" hi Normal guifg=White guibg=Black
" hi Comment guifg=Steelblue guibg=Black

set noshowmode  "don't show mode, is done by lightline
set autochdir

" configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType m setlocal commentstring=%\ %s

" configure indent guides: start indet guides on startup
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" configure vim-table-mode
" let g:table_mode_corner='|'

" setup aliases
command Dws %s/^ \+//       " delete leading whitespace
command Stm :SyntasticToggleMode

" setup new :Shell command to show shell output in a vim window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
endfunction

" Notes
autocmd BufRead,BufNewFile *.note :syn match noteDate /\v\] \zs.*\ze \|/
" autocmd BufRead,BufNewFile *.note :syn match noteDate /^(19|20)\d\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$/
autocmd BufRead,BufNewFile *.note :hi noteDate cterm=underline ctermfg=21 guifg=#0000ff "rgb=0,0,255
autocmd BufRead,BufNewFile *.note :syn match noteHeading /^[A-Z].*/
autocmd BufRead,BufNewFile *.note :hi noteHeading cterm=underline ctermfg=208 guifg=#ff8700 "rgb=255,135,0
autocmd BufRead,BufNewFile *.note :syn match noteComment /^#.*/
autocmd BufRead,BufNewFile *.note :hi noteComment ctermfg=102 guifg=#878787 "rgb=135,135,135
autocmd BufRead,BufNewFile *.note :NoMatchParen
autocmd BufRead,BufNewFile *.note :set noautoindent

" To-do list
autocmd BufRead,BufNewFile *.todo :setl noai nocin nosi inde= " no automatic indent
autocmd BufRead,BufNewFile *.todo nnoremap <leader>n 0o  [ ] 
autocmd BufRead,BufNewFile *.todo nnoremap <leader>x 0f[lrXj
autocmd BufRead,BufNewFile *.todo nnoremap <leader>X 0fXr 
autocmd BufRead,BufNewFile *.todo :syn match todoHeading /^[A-Z].*/
autocmd BufRead,BufNewFile *.todo :hi todoHeading cterm=underline
autocmd BufRead,BufNewFile *.todo :syn match Important /\[.*\!.*$/
autocmd BufRead,BufNewFile *.todo :hi Important ctermfg=4 ctermbg=red
autocmd BufRead,BufNewFile *.todo :NoMatchParen
autocmd BufRead,BufNewFile *.todo :syn match todoDates /\v\] \zs.*\ze \|/
autocmd BufRead,BufNewFile *.todo :hi todoDates cterm=underline
" save to ps file on exit
" autocmd BufUnload *.todo call TodoPdf()
" function TodoPdf()
"    hardcopy > ~/Notes/todo.ps
"   !ps2pdf ~/Notes/todo.ps ~/Notes/pdf/todo.pdf
"   !rm ~/Notes/todo.ps
" endfunction

" disable mouse in vim
set mouse=
set modeline
