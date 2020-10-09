""""""""寓繁于简""""""""""plug管理区""""""""""以简驭繁"""""""""
"""""""""""""""""""""""""""""start"""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
""*********************所有插件请统统写在下面******************
""vim配色方案相关插件
""Explorer:配色方案管理插件```
Plug 'sjas/csExplorer', { 'on': 'ColorSchemeExplorer' }

""Khaki:vim配色方案插件
Plug 'vim-scripts/khaki.vim'

""Molokai:vim配色方案插件
Plug 'tomasr/molokai'

""Gruvbox:vim配色方案插件
Plug 'morhetz/gruvbox'

""Solarized:vim配色方案插件```
Plug 'altercation/vim-colors-solarized'

""Snazzy:vim配色方案插件```
""Plug 'connorholyday/vim-snazzy', { 'on': 'ColorSchemeExplorer' }
""-------------------------------------------------------------------------

" Status line```deprecated
"Plug 'theniceboy/eleline.vim'

""Doxygen:注释自动生成插件
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['c', 'cpp', 'vim-plug'] }

""Startify:炫酷的启动界面```
""Plug 'mhinz/vim-startify'

""Signature:书签管理插件
""Plug 'kshenoy/vim-signature'

""Indentline:缩进线条插件``deprecated
Plug 'yggdroot/indentline', { 'on': 'IndentLinesToggle' }

""NERD:目录插件
""Plug 'vim-scripts/The-NERD-Tree', { 'on': 'NERDTreeToggle' }

""Format:格式化代码插件`^`^can not used
"Plug 'Chiel92/vim-autoformat'

""TrailSpace:清理行尾空格插件
""Plug 'bronson/vim-trailing-whitespace'

""Commentary:代码批量注释插件```deprecated
""Plug 'tpope/vim-commentary', { 'for': ['c', 'cpp', 'vim-plug'] }

""COC:c代码补全插件
"Plug 'WolfgangMehner/c-support',  { 'for': ['c', 'cpp', 'vim-plug'] }
""Plug 'neoclide/coc.nvim', {'branch': 'release'}
""Plug 'prabirshrestha/vim-lsp'

""Spector:代码调试插件
""Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-bash'}

""Highlight:STL高亮插件
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'vim-plug'] }
""Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['c', 'cpp', 'vim-plug'] }

""ACP:字符串自动补全插件```
Plug 'vim-scripts/AutoComplPop'

""Snippets:代码片段插件
Plug 'SirVer/ultisnips'

""InterestWord:可以使用不同颜色同时高亮多个单词
Plug 'lfv89/vim-interestingwords', { 'for': ['c', 'cpp', 'vim-plug'] }

""Cursorword:给当前光标单词增加下划线
""Plug 'itchyny/vim-cursorword', { 'for': ['c', 'cpp', 'vim-plug'] }

""Translater:英语翻译插件```deprecated
""Plug 'ianva/vim-youdao-translater'

""Ctrip:文件路径模糊搜索```deprecated
"Plug 'kien/ctrlp.vim'
""Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/.fzf', 'do': './install --all' }
""-------------------------------------------------------------------------
"Plug 'iamcco/mathjax-support-for-mkdp'

""markdown相关插件
""Table:markdown插入表格
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
""Preview:markdown预览插件`^`^can not uesd
""Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
""Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

""Wiki:vim插入表格```
""Plug 'vimwiki/vimwiki', { 'for': ['markdown', 'wiki', 'vim-plug'] }
""*********************所有插件请统统写在上面******************
call plug#end()            " required
filetype plugin indent on    " required
""""""""""""""""""""""""""""""end""""""""""""""""""""""""""""""




"""""""""""""""""""""""自己添加的默认配置区""""""""""""""""""""
"""""""""""""""""""""""""""""start"""""""""""""""""""""""""""""
"让vim配置保存后立马生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
""**********************VIM快捷键映射""************************
"设置自己的leader(组合键)
let mapleader=","
"let g:mapleader=","
"关于保存退出文件
nnoremap <leader>w :w<CR>
inoremap <C-s> <esc>:w<CR>
nmap <leader>q :q!<CR>
nmap <S-q> :qa!<CR>
"删除一行
inoremap <leader>d <esc>ddi
"批量复制粘贴(+:copy到系统剪切板,a:copy到A这个register中)
vnoremap <leader>y "+y
"vnoremap <leader>y "ay
nmap <leader>p "ap
vnoremap <leader>c "by
nmap <leader>v "bp
"全选(select all)
nnoremap <C-a> ggVG"
inoremap <C-a> <esc>ggVG"
"单行复制粘贴
inoremap <C-d> <esc>yypi
"将当前行上移一行
inoremap <C-S-up> <esc>ddkPi
"将当前行下移一行
inoremap <C-S-down> <esc>ddpi
"撤销
inoremap <C-u> <esc>ui
"反撤销
inoremap <C-r> <esc><C-r>i
noremap U <C-r>
"多窗口跳转<C-k>:up;<C-j>:down;<C-h>:left;<C-l>:right;
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"更改分屏大小(:sp上下分屏;vsp:左右分屏)
nnoremap <space><up> :res +5<CR>
nnoremap <space><down> :res -5<CR>
nnoremap <space><left> :vertical resize-5<CR>
nnoremap <space><right> :vertical resize+5<CR>
"标签页设置:tb(tabnew):打开一个新标签页;
"tn(next):切换到下一个标签页;tp(prefix):切换到上一个标签页
map tb :tabe<CR>
map tp :-tabnext<CR>
map tn :+tabnext<CR>
"分号映射为冒号, 省得要进入命令模式需要按shift
"Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :
"定义快捷键到行首或行尾
nmap H ^
nmap L $
"快速上下移动(一次跳5行)
nmap J 5j
nmap K 5k
"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上下直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
"把搜索到的结果放到屏幕的中间
nnoremap n nzz
nnoremap N Nzz
"调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv
"打开一个新文件和当前文件进行对比
nnoremap <C-d> :vert diffsplit 
"ctrl-s控制拼写检查的开关
nnoremap <C-s> :set spell!<CR>
"ctrl-x:插入模式下弹出拼写检查的提示
inoremap <C-x> <esc>ea<C-x>s
nnoremap s <nop>
"F4键控制行号开关,用于鼠标复制代码
nnoremap <F4> :call HideNumber()<CR>
"F3键控制目录的打开与关闭
""nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :CocCommand explorer<CR>
"F2键为代码添加注释
inoremap <silent> <F2> <esc>:Dox<CR>
",+空格键功能清除行尾空格
""nnoremap <silent> <leader><space> :FixWhitespace<CR>
nnoremap <silent> <leader><space> :call DeleteTrailingWS()<CR>
"ctrl-n进行相对行号/绝对行号切换
nnoremap <silent> <C-n> :call NumberToggle()<cr>
"多窗口编辑时, 临时放大某个窗口, 编辑完再切回原来的布局
nnoremap <silent> <Leader>z :ZoomToggle<CR>
"Call figlet艺术字(ascii banner)
nnoremap tx :r !figlet 
"执行make clean命令
"nnoremap mc :make clean<CR>
"格式化代码
"nnoremap <C-l> ggVG=
"保存, 没权限的时候
" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %
map bb `]
map ee `[
noremap <LEADER>tm :TableModeToggle<CR>
"autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
inoremap ,f <esc>/<++><CR>:nohlsearch<CR>"_c4l
"打开一个新终端并分屏显示
noremap <F12> :term<CR><ESC><C-w>L
"在普通模式下，按 ctrl+t， 会翻译当前光标下的单词；
"在 visual 模式下选中单词或语句，按 ctrl+t，会翻译选择的单词或语句；
"点击引导键再点y，d，可以在命令行输入要翻译的单词或语句；
"译文将会在编辑器底部的命令栏显示。
""vnoremap <silent> <C-T> :<C-u>Ydv<CR>
""nnoremap <silent> <C-T> :<C-u>Ydc<CR>
nnoremap <silent> <C-t> :CocCommand translator.popup<CR>
""noremap <leader>yd :<C-u>Yde<CR>

"开启文件类型侦测
filetype on
"针对不同文件类型采用不同缩进格式
filetype indent on
"针对不同文件类型加载对应的插件
filetype plugin on
"启用自动补全
""filetype plugin indent on
"关闭兼容性
set nocompatible
"设置编码格式为utf-8
set encoding=utf-8
"显示行号
set number
"Tab键的宽度
set tabstop=4
"设置自动对齐为4
set shiftwidth=4
"编辑时backspace为2
set backspace=2
"统一缩进为4
set softtabstop=4
"自动缩进cindent:使用C标准风格缩进
set cin
"智能对齐
set smartindent
"自动对齐
set autoindent
"不要用空格代替制表符
set noexpandtab
"语法高亮
syntax on
"高亮显示对应的括号
set showmatch
"对应括号高亮的时间（单位：1/10s）
set matchtime=10
"开启实时搜索
set incsearch
"开启智能搜索
set smartcase
"搜索时不区分大小写
set ignorecase
"搜索时高亮显示
set hlsearch
"开启vim自身命令行模式智能补全
set wildmenu
"高亮显示光标所在的当前行
set cursorline
"上下移动光标时,光标的上方或下方至少会保留显示的行数
set scrolloff=5
"设置vim执行命令的路径为当前路径
set autochdir
"设置底部状态栏的高度为2
set laststatus=2
"修改未保存时可以切换窗口 TextEdit might fail if hidden is not set.
set hidden
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200
"补全时少打出没用的信息 Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"设置自动保存
set autowrite
"如果文本超过宽度限制(80),画一条数线警告
set colorcolumn=80
"设置tab键的缩进线条\¦\ (here is a space)
""set list lcs=tab:\|\.
"不仅可以显示tab键的缩进,也可以显示行尾结束符
set list
set listchars=trail:▫,tab:\|\.
""set listchars=eol:☺,trail:➤,tab:\|\.
"指定拼写检查字典为英文字典
setlocal spelllang=en_us
"打开拼写检查
"set spell
"高亮光标所在当前列
"set cursorcolumn
"use mouse
"set mouse=a
" 细节调整，主要为了适应 Google C++ Style
" t0: 函数返回类型声明不缩进
" g0: C++ "public:" 等声明缩进一个字符
" h1: C++ "public:" 等声明后面的语句缩进一个字符
" N-s: C++ namespace 里不缩进
" j1: 合理的缩进 Java 或 C++ 的匿名函数，应该也适用于 JS
set cinoptions=t0,g0,h4,N-s,j1
"设置备份文件存放目录
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
"EOL针对不同平台设置不同的行尾符(*nix为\n,win为\r\n)
"mac平台自OS X始，换行符与unix一致;越靠前优先级越高
if has("win32")
	set fileformats=dos,unix,mac
else
	set fileformats=unix,mac,dos
endif

" color
if !has("gui_running")
	set t_Co=256
endif
""选择要使用的配色方案
"colorscheme khaki
let g:molokai_original = 1
let g:rehash256 = 1
""colorscheme molokai
""set background=dark
""colorscheme solarized


""coc.nvim
let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-diagnostic',
	\ 'coc-explorer',
	\ 'coc-clangd',
	\ 'coc-prettier',
	\ 'coc-syntax',
	\ 'coc-translator',
	\ 'coc-vimlsp']

""let g:coc_global_extensions = [
""	\ 'coc-json',
""	\ 'coc-diagnostic',
""	\ 'coc-explorer',
""	\ 'coc-clangd',
""	\ 'coc-gitignore',
""	\ 'coc-lists',
""	\ 'coc-prettier',
""	\ 'coc-snippets',
""	\ 'coc-yank',
""	\ 'coc-tabnine',
""	\ 'coc-syntax',
""	\ 'coc-translator',
""	\ 'coc-vimlsp']
inoremap <silent><expr> <F1>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
""inoremap <silent><expr> <c-space> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""vimspector
""let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
""function! s:read_template_into_buffer(template)
""    " has to be a function to avoid the extra space fzf#run insers otherwise
""    execute '0r ~/.config/nvim/vimspector_json/'.a:template
""endfunction
""command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
""            \   'source': 'ls -1 ~/.config/nvim/vimspector_json',
""            \   'down': 20,
""            \   'sink': function('<sid>read_template_into_buffer')
""            \ })
""noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
""sign define vimspectorBP text=b texthl=Normal
""sign define vimspectorBPDisabled text=🚫 texthl=Normal
""sign define vimspectorPC text=👉 texthl=SpellBad


""" ultisnips
" Trigger configuration. You need to change this to something else than <tab>
" if you use https://github.com/Valloric/YouCompleteMe.
let g:tex_flavor = "latex"
let g:UltiSnipsExpandTrigger="<leader>e"
let g:UltiSnipsJumpForwardTrigger="<C-e>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips/', 'UltiSnips']


" ===
" === vim-table-mode
" ===
"noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
autocmd FileType markdown source ~/.vim/md-snippets.vim
source ~/.vim/optional.vim
autocmd FileType c,cpp,java,sh source ~/.vim/code.vim
"autocmd FileType c,cpp source ~/.vim/test.vim
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.[ch],*.sh,*.java,*.cpp,*.hpp,*.cc  exec ":call SetTitle()"


""设置DoxygenToolkit插件在@author区域自动填充的作者名称
"let g:DoxygenToolkit_authorName="shing"


"""F3键控制目录的打开与关闭
""""设定 NERDTree 视窗大小
""let g:NERDTreeWinSize = 20
"""" 不显示隐藏文件
""let g:NERDTreeHidden=0
"""" 过滤: 所有指定文件和文件夹不显示
""let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '__pycache__']


"打开vim时,自动定位到上次最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"设置C文件一行的宽度限制为80字符
au FileType c,cpp,python,vim set textwidth=80


"auto spell
autocmd BufRead,BufNewFile *.md setlocal spell


"相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
"ctrl-n进行相对行号/绝对行号切换
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber number
	else
		set relativenumber
	endif
endfunc


"为方便复制，用<F4>开启/关闭行号显示:
function! HideNumber()
	if(&relativenumber == &number)
		set relativenumber! number!
	elseif(&number)
		set number!
	else
		set relativenumber!
	endif
	set number?
endfunc


"保存文件时, 自动移除多余空格
"保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
"这个函数通过替换命令删除行尾空格
func! DeleteTrailingWS()
	exec "normal mz"
	%s/\s\+$//ge
	exec "normal `z"
endfunc


"多窗口编辑时, 临时放大某个窗口, 编辑完再切回原来的布局
"Zoom / Restore window.快捷键:<Leader>z控制此功能的开关
function! s:ZoomToggle() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	endif
endfunction
command! ZoomToggle call s:ZoomToggle()
""""""""""""""""""""""""""""""end""""""""""""""""""""""""""""""
""********************end of vim setting***********************
""********************vim所有配置到此结束**********************




""**************************backups""**************************
""**************以下内容都是没有用的备份或注释*****************
""windows下换行符为\r\n,linux下为\n,如果把win下的文件复制到linux
""就可能会产生换行错误,即
""可以用:%s/^M$//g这条命令来消除\r产生的错误
""上面那个方法有时候不管用，我也不知道为什么
""但是可以用:set fileformat=unix这条命令来把win下编辑的东西转成unix
""-------------------------------------------------------------
""调整Ctrl-e/y滚动
"""快速滚动Speed up scrolling of the viewport slightly
""nnoremap <C-e> 50<C-e>
""nnoremap <C-y> 50<C-y>
""-------------------------------------------------------------
""vim命令:
""zz:把当前行放到屏幕中间
""shirt+a:在当前行末尾插入字符
""shirt+i:在当前行首部插入字符
""insert模式下的Ctrl+c:退回普通模式,相当于ESC
""o:在当前行向下插入新行并进入insert;shirt+o:向上插入新行并进入insert
""n:寻找下一个查找的字符;N:寻找上一个查找的字符
""cw(词首):删除当前单词并进入insert;ciw(单词中):删除当前单词并进入insert
""fx:从当前位置寻找x字符,找到后并跳转到x字符
""u:撤销;Ctrl+r:反撤销
""ctrl+o:回到上一次修改的位置;ctrl+i:回到你刚才来的位置
""gf:打开并进入光标所在的文件
""color:改变vim的背景颜色;eg::color morning
""normal模式下z=:(在打开拼写检查的前提下)给出拼写检查的选项
""[s:光标定位到上一个拼写检查认为错误的位置;]s:定位到下一个拼写错误位置
""insert模式下Ctrl+x+s:给出拼写检查可替换单词的选项
"":%TOhtml这条命令就是把当前文件以html的方式输出,方便打印和预览
""-------------------------------------------------------------
""在插入模式下利用表达式寄存器作计算:(不过c-r被我改了,所以用不了)
""在插入模式下，按 ctrl+r ,然后再按 = 就可以利用表达式寄存器进行计算，
""在这时就可以输入加减乘除，最后的结果输入到文本当中；


""git使用方法:
""git init:把当前文件夹初始化为git仓库
""git status:查看当前项目相关信息
""git add <file>...:把文件添加到git仓库
""git diff:比较文件做了哪些修改
""git reset:撤回更改
""git config --global user.name "aqshing":告诉git你是谁
""git config --global user.email "asm.best@email":告诉git你的email
""git commit( -m "xxx"):新添加文件的描述
""git config --global core.editor vim:设置配置文件编辑器为vim
""vim .gitignore:把不想让git追踪的文件写到这里
""git rm --cached <file>...:让git停止追踪这个文件
""git branch( -d/-D):添加一个新的分支;d/(D):(强制)删除分支
""git checkout:切换git分支
""git merge:合并分支
""git remote add origin https:告诉git你的项目在网上的地址在哪
""git push --set-upstream origin master:提交项目
""git config credential.helper store:让git记住你的github的密码
""git clone https:克隆项目到本地的仓库
""git  pull:把别人做的修改下拉到本地




""vim-signature(BookMarks)使用方法
""mx        标记当前行
""dmx       删除标记x
""m<Space>  删除所有标记
""m/        列出所有标记
""]`        跳转到下一个标记
""['        跳转到上一个标记


""Doxygen插件使用说明
""使用时，将光标定位到文件首行，输入:DoxAuthor将插入文件头注释骨架
""（第一次会让你输入文件版本号）
""并把光标停留在@brief 后面，等待输入文件描述。
""在光标定位到数据结构声明或函数声明的第一行，运行:Dox，
""将生成数据结构或函数的注释骨架
""并把光标定位在@brief 后，期待你输入具体的注释内容。


""没用的
"""按<F4>键使用Firefox预览Markdown文件
""nmap <F6> :call Preview()<CR>
""func! Preview()
""    if &filetype == 'markdown' || $filetype == 'md'
""        exec "!chrome %"
""    endif
""endfunc
""" Compile function
""noremap r :call CompileRunGcc()<CR>
""func! CompileRunGcc()
""	exec "w"
""	if &filetype == 'markdown'
""		exec "MarkdownPreview"
""	endif
""endfunc
""
""let g:mkdp_auto_start = 1
""let g:mkdp_auto_close = 1
""let g:mkdp_refresh_slow = 0
""let g:mkdp_command_for_global = 0
""let g:mkdp_open_to_the_world = 0
""let g:mkdp_open_ip = ''
"""let g:mkdp_path_to_chrome = /usr/bin/chromium-browser"
""let g:mkdp_browser = 'chromium'
""let g:mkdp_echo_preview_url = 0
""let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
""let g:mkdp_preview_options = {
""    \ 'mkit': {},
""    \ 'katex': {},
""    \ 'uml': {},
""    \ 'maid': {},
""    \ 'disable_sync_scroll': 0,
""    \ 'sync_scroll_type': 'middle',
""    \ 'hide_yaml_meta': 1,
""    \ 'sequence_diagrams': {},
""    \ 'flowchart_diagrams': {},
""    \ 'content_editable': v:false
""    \ }
""let g:mkdp_markdown_css = ''
""let g:mkdp_highlight_css = ''
""let g:mkdp_port = ''
""let g:mkdp_page_title = '「${name}」'


" ===
" === eleline.vim
" ===
"let g:eleline_powerline_fonts = 0


"\'coc-json',				"json插件
"\ 'coc-diagnostic',			"unknown
"\ 'coc-explorer',			"文件管理器
"\ 'coc-clangd',				"c++插件
"\ 'coc-gitignore',			"git插件
"\ 'coc-lists',				"unknown
"\ 'coc-prettier',			"unknown
"\ 'coc-snippets',			"代码片段插件
"\ 'coc-syntax',				"语法高亮插件
"\ 'coc-translator',			"单词翻译插件
"\'coc-vimlsp']				"vim插件
