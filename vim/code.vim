"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" insert 自动补全括号
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------引号 && 括号自动补全
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap ) <C-r>=ClosePair(')')<CR>
inoremap ] <C-r>=ClosePair(']')<CR>
"inoremap < <><ESC>i
"inoremap > <C-r>=ClosePair('>')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap ` ``<ESC>i
inoremap { {}<ESC>i<CR><ESC>O
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunc


""C语言注释反注释
inoremap x// <esc>:call CommentOfCCode()<CR>i
function! CommentOfCCode()
	if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'java'
		normal 0
		if getline('.')[col('.')] == '/'
			normal df/
		else
			normal i//
			normal j
		endif
	endif
endfunc

""如果是C文件,则将制表符转换为4空格,并打开空格缩进
function! SetTabToSpace()
	if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'java'
		set expandtab
		exec "IndentLinesToggle"
		let g:indentLine_char = '•'
""		let g:indentLine_char = '➤'
""		let g:indentLine_color_term = 239
""		let g:indentLine_color_dark = 1 " (default: 2)
""		let g:indentLine_bgcolor_term = 202
""		let g:indentLine_bgcolor_gui = '#666666'
""		let g:indentLine_char_list = ['♪', '➤', '¦', '┆', '┊']
	endif
endfunc
let g:CallFunction=SetTabToSpace()

func! SetTitle()
	let fileType = expand("%:e")
	if fileType == 'h' || fileType == 'hpp'
		let s:fileName = toupper(expand("%:t"))
		call setline(1, "#ifndef _".s:fileName)
		call append(line("."), "#define _".s:fileName)
		call append(line(".")+1, "")
		call append(line(".")+2, "#endif")
""""""""找到.替换成_
""		normal ggf.r_
""""""""eg:将MAIN.H替换为MAIN_H
""		normal j0f.r_
		normal ggf.r_jr_j
		return
	elseif fileType == 'c' || fileType == 'cpp'
		normal ggifilehead,e
	endif
endfunc
""deprecated```已废弃，不再使用
"新建.c,.h,.sh,.java文件，自动插入文件头
"autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
""func! BackupSetTitle()
""	let fileType = expand("%:e")
""	if fileType == 'h' || fileType == 'hpp'
""		let s:fileName = toupper(expand("%:t"))
""		call setline(1, "#ifndef _".s:fileName)
""		call append(line("."), "#define _".s:fileName)
""		call append(line(".")+1, "")
""		call append(line(".")+2, "#endif")
""""""""""找到.替换成_
""""		normal ggf.r_
""""""""""eg:将MAIN.H替换为MAIN_H
""""		normal j0f.r_
""		normal ggf.r_jr_j
""		return
""	"如果文件类型为.sh文件
""	elseif &filetype == 'sh'
""		call setline(1,"\###################################################")
""		call append(line("."), "\# Filename: ".expand("%"))
""		call append(line(".")+1, "\# Author: shing")
""		call append(line(".")+2, "\# E-mail: www.asm.best")
""		call append(line(".")+3, "\# Created Time: ".strftime("%c"))
""		call append(line(".")+4, "\###################################################")
""		call append(line(".")+5, "\#!/bin/bash")
""		call append(line(".")+6, "")
""	elseif &filetype == 'c' || &filetype == 'java'
""		call setline(1, "/*")
""		call append(line("."), " * =======================================================")
""		call append(line(".")+1, " *")
""		call append(line(".")+2, " *   Filename:  ".expand("%"))
""		call append(line(".")+3, " *")
""		call append(line(".")+4, " *Description:  ")
""		call append(line(".")+5, " *")
""		call append(line(".")+6, " *    Version:  0.01")
""		call append(line(".")+7, " *    Created:  ".strftime("%c"))
""		call append(line(".")+8, " *     Author:  shing www.asm.best")
""		call append(line(".")+9, " *    Company:  NULL")
""		call append(line(".")+10, " *")
""		call append(line(".")+11, " * =======================================================")
""		call append(line(".")+12, " */")
""	elseif &filetype == 'cpp'
""		call setline(1, "//=================================================")
""		call append(line("."), "//")
""		call append(line(".")+1, "//   Filename:  ".expand("%"))
""		call append(line(".")+2, "//")
""		call append(line(".")+3, "//Description:  ")
""		call append(line(".")+4, "//")
""		call append(line(".")+5, "//    Version:  0.01")
""		call append(line(".")+6, "//    Created:  ".strftime("%c"))
""		call append(line(".")+7, "//     Author:  shing www.asm.best")
""		call append(line(".")+8, "//    Company:  NULL")
""		call append(line(".")+9, "//")
""		call append(line(".")+10, "//=================================================")
""		call append(line(".")+11, "#include <iostream>")
""		call append(line(".")+12, "using namespace std;")
""		call append(line(".")+13, "")
""		call append(line(".")+14, "")
""		call append(line(".")+15, "int main(int argc, const char* argv[])")
""		call append(line(".")+16, "{")
""		call append(line(".")+17, "    <++>")
""		call append(line(".")+18, "    return 0;")
""		call append(line(".")+19, "}")
""	endif
""""	if &filetype == 'c' || &filetype == 'java'
""""		call setline(1, "/*")
""""		call append(line("."),   " * ============================================================================")
""""		call append(line(".")+1, " *")
""""		call append(line(".")+2, " *       Filename:  ".expand("%"))
""""		call append(line(".")+3, " *          motto:  We don't produce code, we're just GitHub porters!")
""""		call append(line(".")+4, " *    Description:  我们不生产代码，我们只是GitHub的搬运工")
""""		call append(line(".")+5, " *")
""""		call append(line(".")+6, " *        Version:  1.0")
""""		call append(line(".")+7, " *        Created:  ".strftime("%c"))
""""		call append(line(".")+8, " *       Compiler:  gcc")
""""		call append(line(".")+9, " *")
""""		call append(line(".")+10," *         Author:  shing www.asm.best")
""""		call append(line(".")+11," *          Email:  ")
""""		call append(line(".")+12," *   Organization:  ")
""""		call append(line(".")+13," *")
""""		call append(line(".")+14," * ===========================================================================")
""""		call append(line(".")+15," */")
""""		call append(line(".")+16,"")
""""	endif
""	"新建文件后，自动将光标定位到文件末尾
""	normal Go
""	"autocmd BufReadCmd * <Esc>/<++><CR>:nohlsearch<CR>"_c4l
""endfunc


" Compile function
noremap <F7> :call CompileCode()<CR>
inoremap <F7> <esc>:call CompileCode()<CR>
func! CompileCode()
	exec "w"
	if &filetype == 'c' || &filetype == 'cpp'
		if &filetype == 'c'
			set makeprg=gcc\ --std=c99\	-Wall\ -g\ -O0\ -o\ %<\ %
		else
			set makeprg=g++\ -std=c++11\ -Wall\ -g\ -O0\ -o\ %<\ %
		endif
		silent exe "make"
		if getqflist() == []    "compile correct and no warning
			let l:flag = 0 | silent exe "cclose" | exe "!%<"
		else
			for l:inx in getqflist()
				for l:val in values(l:inx)
					if l:val =~ 'error' | let l:flag = 1 | break
					elseif l:val =~ 'warning' | let l:flag = 2
					else | let l:flag = 0
					endif
				endfor
				if l:val =~ 'error' | break | endif
			endfor
		endif
		if l:flag == 1| exe "cw"
		elseif l:flag == 2
			let l:select = input('There are warnings! [r]un or [s]olve? ')
			if l:select ==  'r' | exe "!%<" | exe "cw"
			elseif l:select == 's' | exe "cw"
			else | echoerr "input error!"
			endif
		else | exe "cw"
		endif
	elseif &filetype == 'java'
		exec "!javac -encoding utf-8 %"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	else
		echohl ErrorMsg | echo "This filetype can't be compiled !"
	endif
	"防止多次编译黑屏
	exec "update"
    redraw!
endfunc


" Run
noremap <F5> :call RunCode()<CR>
inoremap <F5> <esc>:call RunCode()<CR>
func! RunCode()
	exec "w"
	if &filetype == 'c' || &filetype == 'cpp'
		exec 'cclose'
		set splitbelow
		if has('nvim')
			:sp
		endif
		:term ./%<
		:res -8
	elseif &filetype == 'java'
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	else
		echohl ErrorMsg | echo "This filetype can't run !"
	endif
	echohl None
endfunc


""if executable('pyls')
""    " pip install python-language-server
""    au User lsp_setup call lsp#register_server({
""        \ 'name': 'pyls',
""        \ 'cmd': {server_info->['pyls']},
""        \ 'allowlist': ['python'],
""        \ })
""endif
""
""function! s:on_lsp_buffer_enabled() abort
""    setlocal omnifunc=lsp#complete
""    setlocal signcolumn=yes
""    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
""    nmap <buffer> gd <plug>(lsp-definition)
""    nmap <buffer> gr <plug>(lsp-references)
""    nmap <buffer> gi <plug>(lsp-implementation)
""    nmap <buffer> gt <plug>(lsp-type-definition)
""    nmap <buffer> <leader>rn <plug>(lsp-rename)
""    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
""    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
""    nmap <buffer> K <plug>(lsp-hover)
""
""    " refer to doc to add more commands
""endfunction
""
""augroup lsp_install
""    au!
""    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
""    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
""augroup END
