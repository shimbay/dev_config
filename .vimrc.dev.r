" Steps:
" - dependency
"   ```
"   sudo add-apt-repository ppa:git-core/ppa
"   sudo apt update
"   sudo apt install -y libncurses-dev autoconf python3-pip pkg-config software-properties-common libtool libtool-bin mono-complete git universal-ctags gettext libgettextpo-dev zip cmake ninja-build python3.9-dev clangd luarocks
"   pip3 install --upgrade pynvim yapf toml black cmakelang jsbeautifier --user
"   ```
"
" - ripgrep
"   ```
"   https://github.com/BurntSushi/ripgrep/releases
"   ```
"
" - cmake
"   ```
"   https://cmake.org/download/
"
"   version=3.26.4; wget -O /tmp/cmake_install.sh https://github.com/Kitware/CMake/releases/download/v$version/cmake-$version-linux-x86_64.sh && bash /tmp/cmake_install.sh --skip-license --prefix=$WORKSPACE
"   ```
"
" - fzf
"   ```
"   https://github.com/junegunn/fzf/releases
"
"   version="0.66.1"; wget -O - https://github.com/junegunn/fzf/releases/download/v$version/fzf-$version-linux_amd64.tar.gz | tar -zxvf - -C $WORKSPACE/bin
"   ```
"
" - go
"   ```
"   https://go.dev/dl/
"
"   version=1.25.4; rm -rf $WORKSPACE/dev/go.old; test -d $WORKSPACE/dev/go && mv $WORKSPACE/dev/go $WORKSPACE/dev/go.old; wget -O - https://go.dev/dl/go$version.linux-amd64.tar.gz | tar -zxvf - -C $WORKSPACE/dev
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
"   https://nodejs.org/en/download
"
"   version=v24.11.1; rm -rf $WORKSPACE/dev/node.old; test -d $WORKSPACE/dev/node && mv $WORKSPACE/dev/node $WORKSPACE/dev/node.old; wget -O - https://nodejs.org/dist/$version/node-$version-linux-x64.tar.xz | tar -Jxvf - -C $WORKSPACE/dev && rm -rf node && mv $WORKSPACE/dev/node-$version-linux-x64 $WORKSPACE/dev/node
"   ln -s $WORKSPACE/dev/node/bin/node $WORKSPACE/bin && ln -s $WORKSPACE/dev/node/bin/npm $WORKSPACE/bin && ln -s $WORKSPACE/dev/node/bin/npx $WORKSPACE/bin
"   ```
"
" - yarn
"   ```
"   npm install --global yarn prettier
"   ```
"
" - clangd
"   ```
"   https://discourse.llvm.org/c/announce/46
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
"   :PluginUpdate
"   ```
"
" - coc
"   ```
"   cd ~/.vim/bundle/coc.nvim && git checkout master && git pull && yarn install --frozen-lockfile
"
"   :CocInstall coc-snippets coc-highlight coc-json coc-lists coc-clangd coc-go coc-pyright coc-rls coc-cmake coc-mlir coc-lua
"   :CocUpdate
"   ```
"
" - vimspector
"   ```
"   mkdir -p $HOME/.vim/pack/vimspector/opt && ln -s $HOME/.vim/bundle/vimspector $HOME/.vim/pack/vimspector/opt
"
"   :VimspectorInstall
"   :VimspectorUpdate
"   ```
"
" - vim-go
"   ```
"   :GoInstallBinaries
"   :GoUpdateBinaries
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
Plugin 'tpope/vim-surround'
Plugin 'tveskag/nvim-blame-line'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vim-scripts/taglist.vim'

Plugin 'antiagainst/vim-tablegen'
Plugin 'hunterzju/mlir-vim'

" All of your Plugins must be added before the following line
call vundle#end()

call glaive#Install()

let g:material_theme_style = 'darker'
colorscheme material
highlight Normal guibg=#151515

" coc begin

" CocCommand semanticTokens.checkCurrent
" CocCommand semanticTokens.inspect
" CocCommand workspace.showOutput clangd

" help coc-config-semanticTokens-enable
" help CocSem
 
" clangd`s symbol link bug: https://github.com/clangd/clangd/issues/503
"
" CocSemTypeMod + type + modifier

" https://htmlcolorcodes.com/
highlight CursorLine guibg=#353535
highlight Comment guifg=#727272
highlight LineNr guifg=#727272
highlight CursorLineNr guifg=#00A42B gui=bold
highlight Visual guibg=#414141

highlight CocHighlightText guibg=#005057
highlight CocFloating ctermbg=236
highlight CocSearch ctermfg=208

highlight SemColorRed guifg=#E46B37
highlight SemColorPulple guifg=#AE5AE8 gui=bold

highlight link CocSemTypeTypeParameter CocSemTypeClass
highlight link CocSemTypeModPropertyClassScope SemColorRed
highlight link CocSemTypeModPropertyDeclaration SemColorRed
highlight link CocSemTypeProperty SemColorRed
highlight link CocSemTypeEnumMember SemColorPulple
highlight link CocSemTypeModEnumMemberDeclaration SemColorPulple
highlight link CocSemTypeNamespace CocSemTypeOperator

imap <C-j> <C-n>
imap <C-k> <C-p>

map <C-c> :CocListCancel<CR>
map <C-m> :CocListResume<CR>

map <C-s> :CocList -A -I symbols<CR>
map <C-n> :CocList files<CR>
map <C-g> :CocList changes<CR>
map <C-f> :CocList -A -I grep<CR>

map <leader>hi :CocCommand semanticTokens.inspect<CR>

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
      \ [ 'z']
      \ ]
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }
let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', '%4(%c%V%)'])
" vim-airline/vim-airline end

" google/vim-codefmt begin
Glaive codefmt js_beautify_executable='js_beautify_1'

au BufRead,BufNewFile *.mlir set filetype=mlir
autocmd FileType c,cpp,proto let b:codefmt_formatter = "clang-format"
let g:clang_format#command = "clang-format"
let g:clang_format#detect_style_file = 1

autocmd FileType python AutoFormatBuffer black
autocmd FileType python NoAutoFormatBuffer

autocmd FileType sh AutoFormatBuffer shfmt
autocmd FileType sh NoAutoFormatBuffer

autocmd FileType proto AutoFormatBuffer clang-format
autocmd FileType proto NoAutoFormatBuffer

autocmd FileType json AutoFormatBuffer js-beautify
autocmd FileType json NoAutoFormatBuffer

autocmd FileType go AutoFormatBuffer gofmt
autocmd FileType rust AutoFormatBuffer rustfmt
autocmd FileType CMakeLists.txt AutoFormatBuffer cmake-format
autocmd FileType lua AutoFormatBuffer luaformatterfiveone

nmap <silent> <leader>f :FormatCode<CR>
vmap <silent> <leader>f :FormatLines<CR>
vmap <silent> <leader>c "+y
" google/vim-codefmt end

" nerdtree begin
nnoremap <silent> ' :NERDTreeToggleVCS<CR>
nnoremap <silent> . :NERDTreeFind<CR>

let g:NERDTreeAutoCenter = 0
let g:NERDTreeIgnore = ['\.pyc','\~$','\.swp']
let g:NERDTreeQuitOnOpen = 0
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
nnoremap <silent> \\ :diffget<CR> 
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
let g:go_textobj_enabled = 0

nnoremap <silent> <leader>tj :GoAddTags json<CR>
" vim-go end

" vim-python/python-syntax begin
let g:no_plugin_maps = 1
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
let g:vimspector_console_max_lines = 0
let g:vimspector_terminal_maxwidth = 50
let g:vimspector_bottombar_height = 0
let g:vimspector_settings = {
    \ 'showInternalConsole': 0,
    \ 'consoleHeight': 0,
    \ 'consoleVisible': 0
    \ }

autocmd User VimspectorUICreated silent! bdelete! Console[0]

nmap <F3> :call vimspector#Launch()<CR>
nmap , :call vimspector#Launch()<CR>
nmap <S-F4> :call vimspector#Restart()<CR>
nmap <F4> :call vimspector#Reset()<CR>
nmap 4 :call vimspector#Reset()<CR>

nmap <F5> <Plug>VimspectorToggleBreakpoint
nmap 5 <Plug>VimspectorToggleBreakpoint
nmap <F6> <Plug>VimspectorToggleConditionalBreakpoint
nmap 6 <Plug>VimspectorToggleConditionalBreakpoint

nmap <F7> <Plug>VimspectorStepInto
nmap 7 <Plug>VimspectorStepInto
nmap <F8> <Plug>VimspectorStepOver
nmap 8 <Plug>VimspectorStepOver
nmap <F9> <Plug>VimspectorContinue
nmap 9 <Plug>VimspectorContinue
nmap <F10> <Plug>VimspectorRunToCursor
nmap <S-9> <Plug>VimspectorRunToCursor

packadd! vimspector
" puremourning/vimspector end

" tveskag/nvim-blame-line begin
nmap <leader>m :ToggleBlameLine<CR>
let g:blameLineVirtualTextFormat = '    %s'
let g:blameLineGitFormat = '%an | %ai | %s | %h'
" tveskag/nvim-blame-line end
