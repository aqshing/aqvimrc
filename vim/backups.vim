""https://segmentfault.com/a/1190000021857407
function TimeStamp()
"    let save_cursor= getpos(".")
    let win_view = winsaveview()
    %s/\(Last Change\s*:\s*\)\(.*\)$/\=submatch(1).strftime("%Y-%m-%d %H:%M:%S")/ge
    %s/\(Last Modified\s*:\s*\)\(.*\)$/\=submatch(1).strftime("%Y-%m-%d %H:%M:%S")/ge
    %s/\(Update Count\s*:\s*\)\(\d\+\)/\=submatch(1).(submatch(2)+1)/ge
"    call setpos('.', save_cursor)
    call winrestview(win_view)
endfunction
command -nargs=0 TimeStamp call TimeStamp()

function AutoTimeStamp()
    augr tagdate
    au!
    au BufWritePost,FileWritePost * call TimeStamp()
    augr END
endfunction
command -nargs=0 AutoTimeStamp call AutoTimeStamp()

if !exists('*Preserve_view')
    function! Preserve_view(command)
        " Preparation: save last search, and cursor position.
        let win_view = winsaveview()
        let old_query = getreg('/')
        execute 'keepjumps ' . a:command
        " Clean up: restore previous search history, and cursor position
        call winrestview(win_view)
        call setreg('/', old_query)
    endfunction
endif

fun! CleanExtraSpaces()
    call Preserve_view('%s/\s\+$//ge')
endfunc
com! Clsspace :call CleanExtraSpaces()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last change用到的函数，返回时间，能够自动调整位置
" https://blog.csdn.net/iteye_2251/article/details/81897779
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! TimeStamp(...)
	let sbegin = ''
	let send = ''
	let pend = ''
	if a:0 >= 1
		let sbegin = '' . a:1
		let sbegin = substitute(sbegin, '*', '\\*', "g")
		let sbegin = sbegin . '\s*'
	endif
	if a:0 >= 2
		let send = '' . a:2
		let pend = substitute(send, '*', '\\*', "g")
	endif
	let pattern = 'Last Change: .\+' . pend
	let pattern = '^\s*' . sbegin . pattern . '\s*$'
	let now = strftime('%Y-%m-%d %H:%M:%S',localtime())
	let row = search(pattern, 'n')
	echo row
	if row  == 0
		let now = a:1 . 'Last Change:  ' . now . send
		call append(2, now)
		echo now
	else
		let curstr = getline(row)
		let col = match( curstr , 'Last')
		let now = a:1 . 'Last Change:  ' . now . send
		call setline(row, now)
	endif
endfunction
"" Last Change:  2010-07-29 18:50:39
au BufWritePre _vimrc call TimeStamp('" ')
" * Last Change:  2010-07-29 18:50:39
au BufWritePre *.js,*.css call TimeStamp(' * ')
"# Last Change:  2010-07-29 18:50:39
au BufWritePre *.rb,*.py,*.sh call TimeStamp('# ')


""deprecated```已废弃，不再使用(原来在code.vim里面)
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
