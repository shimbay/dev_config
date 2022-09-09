" Steps:
" - dependency
"   ```
"   sudo add-apt-repository ppa:git-core/ppa
"   sudo apt update
"   sudo apt install -y libncurses-dev autoconf python3-pip pkg-config software-properties-common libtool libtool-bin mono-complete git
"   pip3 install --upgrade pynvim yapf toml black cmakelang jsbeautifier --user
"   ```
"
" - ripgrep
"   ```
"   https://github.com/BurntSushi/ripgrep/releases
"   ```
"
" - ctags
"   ```
"   https://github.com/universal-ctags/ctags#how-to-build-and-install
"
"   git clone https://github.com/universal-ctags/ctags.git
"   cd ctags && ./autogen.sh && ./configure --prefix=$WORKSPACE
"   make -j 10 && make install
"   ```
"
" - cmake
"   ```
"   https://cmake.org/download/
"
"   version=3.23.1
"   wget -O /tmp/cmake_install.sh https://github.com/Kitware/CMake/releases/download/v$version/cmake-$version-linux-x86_64.sh 
"   bash /tmp/cmake_install.sh --skip-license --prefix=$WORKSPACE
"   ```
"
" - go
"   ```
"   https://www.gomirrors.org/
"
"   version=1.18.3
"   rm -rf $WORKSPACE/dev/go && wget -O - https://gomirrors.org/dl/go/go$version.linux-amd64.tar.gz | tar -zxvf - -C $WORKSPACE/dev
"   ln -s $WORKSPACE/dev/go $WORKSPACE/bin
"   ```
"
" - rust
"   ```
"   Linux: curl https://sh.rustup.rs -sSf | sh
"   WSL: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
"
"   rustup component add rls rust-analysis rust-src
"   ```
"
" - shfmt
"   ```
"   go install mvdan.cc/sh/v3/cmd/shfmt@latest
"   ```
"
" - node.js & npm
"   ```
"   wget -O - https://install-node.now.sh/lts | bash /dev/stdin --prefix=$WORKSPACE
"   ```
"
" - yarn
"   ```
"   npm install --global yarn prettier
"   ```
"
" - clangd
"   ```
"   Linux: https://releases.llvm.org/download.html
"   MacOS: brew install llvm
"
"   ln -s ${WORKSPACE}/dev/llvm ${WORKSPACE}/bin/llvm
"   ```
" 
" - vim plugin
"   ```
"   vim
"   :PluginInstall
"   ```
"
" - coc
"   ```
"   cd ~/.vim/bundle/coc.nvim && git checkout release && yarn install --frozen-lockfile
"
"   :CocInstall coc-snippets coc-highlight coc-json coc-lists coc-clangd coc-go coc-pyright coc-rls
"   ```
"
" - vimspector
"   ```
"   mkdir -p $HOME/.vim/pack/vimspector/opt && ln -s $HOME/.vim/bundle/vimspector $HOME/.vim/pack/vimspector/opt
"
"   :VimspectorInstall
"   ```
"
" - vim-go
"   ```
"   :GoInstallBinaries
"   ```

set rtp+=~/.vim/bundle/Vundle.vim

" Keep Plugin commands between vundle#begin/end.
call vundle#begin()

Plugin 'airblade/vim-gitgutter'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'fatih/vim-go'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-glaive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kaicataldo/material.vim'
Plugin 'neoclide/coc.nvim'
Plugin 'preservim/tagbar'
Plugin 'puremourning/vimspector'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-python/python-syntax'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vim-scripts/taglist.vim'

" All of your Plugins must be added before the following line
call vundle#end()

" set termguicolors
colorscheme material

" coc begin
highlight CursorLine ctermbg=236 guibg=#1a2327
highlight CocHighlightText ctermbg=52 guibg=#1a2327
highlight CocFloating ctermbg=233

highlight CocSemProperty ctermfg=Red
highlight CocSemNamespace ctermfg=208

highlight link CocSemVariable CocSemParameter
highlight link CocSemEnumMember CocSemMacro

imap <C-j> <C-n>
imap <C-k> <C-p>

map <C-c> :CocListCancel<CR>
map <C-m> :CocListResume<CR>

map <C-s> :CocList -A -I symbols<CR>
map <C-n> :CocList files<CR>
map <C-g> :CocList changes<CR>
map <C-f> :CocList -A -I grep<CR>
map <C-e> :CocDiagnostics<CR>

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<s-tab>'

nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)
nmap <silent> <leader>R <Plug>(coc-rename)
nmap <silent> <leader>h :call <SID>show_documentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocStatusChange redraws
" coc end

" vim-airline/vim-airline begin
let g:airline#extensions#default#layout = [
      \ [ 'a', 'c' ],
      \ [ 'x', 'y', 'z', 'error']
      \ ]
" vim-airline/vim-airline end

" google/vim-codefmt begin
autocmd FileType c,cpp,proto let b:codefmt_formatter = "clang-format"
let g:clang_format#command = "clang-format"
let g:clang_format#detect_style_file = 1

autocmd FileType python AutoFormatBuffer black
autocmd FileType python NoAutoFormatBuffer

autocmd FileType sh AutoFormatBuffer shfmt
autocmd FileType sh NoAutoFormatBuffer

autocmd FileType go AutoFormatBuffer gofmt
autocmd FileType rust AutoFormatBuffer rustfmt
autocmd FileType cmake AutoFormatBuffer cmake-format

nmap <silent> <leader>f :FormatCode<CR>
vmap <silent> <leader>f :FormatLines<CR>
" google/vim-codefmt end

" nerdtree begin
nnoremap <silent> ' :NERDTreeToggleVCS<CR>
nnoremap <silent> . :NERDTreeFind<CR>

let g:NERDTreeAutoCenter = 0
let g:NERDTreeIgnore = ['\.pyc','\~$','\.swp']
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeWinSize = 35
let g:NERDTreeWinPos = "left"
" nerdtree end 

" Xuyuanp/nerdtree-git-plugin begin
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ 'Ignored'   : '☒',
  \ "Unknown"   : "?"
  \ }
" Xuyuanp/nerdtree-git-plugin end

" vim-nerdtree-tabs begin
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_autofind = 0
" vim-nerdtree-tabs end

" preservim/tagbar begin
nnoremap <silent> T :TagbarToggle<CR>
nnoremap <silent> <leader>n :TagbarJumpNext<CR>
nnoremap <silent> <leader>p :TagbarJumpPrev<CR>

let g:tagbar_width = 24
let g:tagbar_compact = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_foldlevel = 2
let g:tagbar_map_preview = 'o'
let g:tagbar_map_jump = 'O'
let g:tagbar_map_togglefold = 'f'
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds' : [
    \ 'p:package',
    \ 'i:imports:0',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin' : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_cpp = {
  \ 'ctagstype' : 'c++',
  \ 'kinds' : [
    \ 'd:macros:1:0',
    \ 'p:prototypes:1:0',
    \ 'g:enums',
    \ 'e:enumerators:0:0',
    \ 't:typedefs:0:0',
    \ 'n:namespaces',
    \ 'c:classes',
    \ 's:structs',
    \ 'u:unions',
    \ 'f:functions',
    \ 'm:members:0:0',
    \ 'v:variables:0:0'
  \ ],
  \ 'sro' : '::',
  \ 'kind2scope' : {
    \ 'g' : 'enum',
    \ 'n' : 'namespace',
    \ 'c' : 'class',
    \ 's' : 'struct',
    \ 'u' : 'union'
  \ },
  \ 'scope2kind' : {
    \ 'enum' : 'g',
    \ 'namespace' : 'n',
    \ 'class' : 'c',
    \ 'struct' : 's',
    \ 'union' : 'u'
  \ }
\ }

let g:tagbar_use_cache = 0
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
    \ 'n:modules',
    \ 's:structures:1',
    \ 'i:interfaces',
    \ 'c:implementations',
    \ 'f:functions:1',
    \ 'g:enumerations:1',
    \ 't:type aliases:1:0',
    \ 'v:constants:1:0',
    \ 'M:macros:1',
    \ 'm:fields:1:0',
    \ 'e:enum variants:1:0',
    \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
    \ 'n': 'module',
    \ 's': 'struct',
    \ 'i': 'interface',
    \ 'c': 'implementation',
    \ 'f': 'function',
    \ 'g': 'enum',
    \ 't': 'typedef',
    \ 'v': 'variable',
    \ 'M': 'macro',
    \ 'm': 'field',
    \ 'e': 'enumerator',
    \ 'P': 'method',
  \ },
\ }
" preservim/tagbar end

" tpope/vim-fugitive begin
nnoremap <silent> <leader>gs :Git!<CR>
nnoremap <silent> <leader>gl :Git log<CR>
nnoremap <silent> <leader>gd :Gvdiffsplit!<CR>
nnoremap <leader>gD :Gvdiffsplit! 
nnoremap <silent> <leader>gg :diffget<CR> 
nnoremap <silent> <leader>gb :Git blame<CR>
" tpope/vim-fugitive end

" vim-scripts/DoxygenToolkit.vim begin
let g:load_doxygen_syntax = 1

nnoremap <silent> <leader>mc :Dox<CR>
nnoremap <silent> <leader>ma gg \| :DoxAuthor<CR>
" vim-scripts/DoxygenToolkit.vim end

" vim-go begin 
nnoremap <silent> <leader>o :GoImports<CR>

let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_format_strings = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_calls = 1
let g:go_auto_sameids = 0
let g:go_updatetime = 800
let g:godef_split = 2
let g:go_def_mapping_enabled = 0

nnoremap <silent> <leader>tj :GoAddTags json<CR>
" vim-go end

" vim-python/python-syntax begin
let g:python_highlight_all = 1
let g:python_highlight_builtins = 1
let g:python_highlight_builtin_objs = 1
let g:python_highlight_builtin_types = 1
let g:python_highlight_builtin_funcs = 1
let g:python_highlight_builtin_funcs_kwarg = 1
let g:python_highlight_string_formatting = 1
let g:python_highlight_string_format = 1
let g:python_highlight_string_templates = 1
let g:python_highlight_indent_errors = 1
let g:python_highlight_space_errors = 1
let g:python_highlight_func_calls = 1
let g:python_highlight_func_calls = 1
" vim-python/python-syntax end

" puremourning/vimspector begin
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'vscode-go' ]
let g:vimspector_terminal_maxwidth = 50
let g:vimspector_bottombar_height = 10

nmap <F3> :call vimspector#Launch()<CR>
nmap <S-F4> :call vimspector#Restart()<CR>
nmap <F4> :call vimspector#Reset()<CR>

nmap <F5> :call vimspector#ToggleBreakpoint()<CR>
nmap <F6> :call vimspector#ToggleConditionalBreakpoint()<CR>

nmap <F7> :call vimspector#StepInto()<CR>
nmap <F8> :call vimspector#StepOver()<CR>
nmap <F9> :call vimspector#Continue()<CR>
nmap <F10> :call vimspector#RunToCursor()<CR>

packadd! vimspector
" puremourning/vimspector end
"
" autocmd TermOpen * startinsert
