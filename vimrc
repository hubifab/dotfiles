set nocompatible              " be iMproved, required
filetype off                  " required
scriptencoding utf-8
set encoding=utf-8
set t_Co=256

" set the runtime path to include Vundle and initialize
" install Vundle: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/VundleVim/Vundle.vim.git'
" Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/itchyny/lightline.vim'
" Plugin 'https://github.com/vim-airline/vim-airline'
Plugin 'https://github.com/vim-syntastic/syntastic.git'
Plugin 'https://github.com/tpope/vim-commentary.git'
Plugin 'https://github.com/xtal8/traces.vim'
Plugin 'https://github.com/dhruvasagar/vim-table-mode'
Plugin 'https://github.com/plasticboy/vim-markdown'
Plugin 'https://github.com/godlygeek/tabular.git'
" Plugin 'godlygeek/tabular'
" NOTE: indentLine messes with concealcursor and conceallevel! (see g.indentLine section)
Plugin 'https://github.com/Yggdroot/indentLine'
Plugin 'https://github.com/vim-scripts/indentpython.vim.git'
" Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plugin 'https://github.com/mileszs/ack.vim.git'
" Plugin 'https://github.com/rhysd/vim-clang-format.git'
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
set history=1000  " Store up to a thousand items in the command history

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

" Softtabs, 4 spaces
set tabstop=4
set shiftwidth=4
" set conceal level to 0: don't hide any symbols for latex!
" let g:tex_conceal = ""
set conceallevel=0
" set concealcursor=nc " reveal concealed code in insert mode
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 100 characters is
set textwidth=100
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

" insert current date
nnoremap <Leader>d :pu=strftime('%Y-%m-%d')<CR>

" insert current time
nnoremap <Leader>t :pu=strftime('%H:%M')<CR>

" Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

" Toggle Table Mode
" start with | ... | ; next line type || ; [| and ]| to jump between cols
nnoremap <Leader>tm :ToggleTableMode<space>

" execute/run current line as vim command
nnoremap <Leader>cm yy:@"<CR>

" show buffers
nnoremap <Leader>b :ls<CR>:b<space>

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

" reset last search (, + space)
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

" Toggle nerdtree
" map <C-n> :NERDTreeToggle<CR>
" Toggle syntastic active/passive mode
map <C-s> :SyntasticToggleMode<CR>
" Can be typed even faster than jj.
imap jk <Esc>

" line swapping with
nnoremap <Leader>j ddp
nnoremap <Leader>k ddkP

" cycle tabs
nnoremap <Leader>l gt
nnoremap <Leader>h gT
" switch to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-g> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-g> :exe "tabn ".g:lasttab<cr>

" copy/paste from system clipboard - set clipboard=unnamed activates system clipboard as default
nnoremap <Leader>y ^"+y$
nnoremap <Leader>p "+p

" activate syntax code folding
" za: toggle fold, zR: unfold all, zM: fold all
set foldnestmax=1 " only fold functions, not the nested if, while, etc.
set nofoldenable
nnoremap <Leader>cf :setlocal foldmethod=syntax<CR>

" make sure folded code blocks are retained after files are closed
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" toggle spell check
nnoremap <Leader>sp :setlocal spell!<CR>

" Lars' snippets
" find the word under cursor using grep/ack
noremap <Leader>g :Ack!<space>-w<space><C-r><C-w><CR>
" git-log of current file
" noremap <Leader>l :!git<space>log<space>-p<space>--follow<space>%<CR>
" search for word under curosr in git-history (search complete repository)
" noremap <Leader>t :!git<space>log<space>-p<space>-S<space><C-r><C-w><CR>
" search for word under curosr in git-history (current file only)
" noremap <Leader>T :!git<space>log<space>-p<space>--follow<space>-S<space><C-r><C-w><space>--<space>%<CR>

" setup aliases
command Dlws %s/^ \+//                     " delete leading whitespace
command Dtws %s/\s\+$//                    " delete trailing whitespace

" command Stm :SyntasticToggleMode          " toggle syntax checker
command Spellde :setlocal spelllang=de_de " set spell check language to DE
command Spellen :setlocal spelllang=en_us " set spell check language to EN
" reformat file using clang-format
command Clang !clang-format -i -style="{BasedOnStyle: llvm, BreakBeforeBraces: Linux, IndentWidth: 4, PointerAlignment: Left }" %

set nowrap
set hls!
set ai
set ignorecase
highlight Normal ctermbg=black ctermfg=white
highlight iCursor guifg=white guibg=steelblue
set cursorline

if version >= 800      " only set termguicolors when vim version is 8 or greater
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
"set autochdir   " autmatically change working directory of the buffer to path of loaded file

" configure clang-format
" let g:clang_format#style_options = {
"             \ "BreakBeforeBraces" : "Linux",
"             \ "IndentWidth" : 4,
"             \ "PointerAlignent" : "Left"}

" configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_check_header = 1
" define folders for syntastic to look for includes
let g:syntastic_c_include_dirs = [ '../include', 'include', '/home/fab/programs/gcc-arm-none-eabi-10-2020-q4-major/arm-none-eabi/include', '../external/uaq/include' ]
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType m setlocal commentstring=%\ %s

let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""

" configure indent guides: start indet guides on startup
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" configure vim-table-mode
" let g:table_mode_corner='|'

"  configure vim-markdown
let g:vim_markdown_strikethrough = 1

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

" auto setup for file types
" tex
autocmd FileType tex set concealcursor=nc

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

" To-do list in Markdown
autocmd BufRead,BufNewFile *.md :setl noai nocin nosi inde= " no automatic indent
autocmd BufRead,BufNewFile *.md nnoremap <leader>n 0o- [ ]
autocmd BufRead,BufNewFile *.md nnoremap <leader>x 0f[lrXj
autocmd BufRead,BufNewFile *.md nnoremap <leader>X 0fXr
autocmd BufRead,BufNewFile *.md :syn match todoHeading /^[A-Z].*/
autocmd BufRead,BufNewFile *.md :hi todoHeading cterm=underline
autocmd BufRead,BufNewFile *.md :syn match Important /\[.*\!.*$/
autocmd BufRead,BufNewFile *.md :hi Important ctermfg=4 ctermbg=red
autocmd BufRead,BufNewFile *.md :NoMatchParen
autocmd BufRead,BufNewFile *.md :syn match todoDates /\v\] \zs.*\ze \|/
autocmd BufRead,BufNewFile *.md :hi todoDates cterm=underline
autocmd BufRead,BufNewFile *.md :set concealcursor=

" CFlow callgraph file
autocmd BufNewFile,BufRead *.cflow setf cflow

" save to ps file on exit
" autocmd BufUnload *.todo call TodoPdf()
" function TodoPdf()
"    hardcopy > ~/Notes/todo.ps
"   !ps2pdf ~/Notes/todo.ps ~/Notes/pdf/todo.pdf
"   !rm ~/Notes/todo.ps
" endfunction

" set conceal level to 0: don't hide any symbols for latex!
" let g:tex_conceal = ""
set conceallevel=0
" set concealcursor=nc " reveal concealed code under the cursor line in insert mode

" disable mouse in vim
set mouse=
set modeline

" added this for st (suckless terminal) to enable true color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" highlight unnecessary extra whitespace
" https://vim.fandom.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" adjust highlight color under cursor for diff
hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2

" adjust highlight colors for spell check
highlight clear SpellCap
highlight SpellCap ctermbg=darkblue
highlight clear SpellLocal
highlight SpellLocal ctermbg=darkblue
highlight clear SpellBad
highlight SpellBad ctermbg=darkred

" load optional local vimrc
" so .vimrc
