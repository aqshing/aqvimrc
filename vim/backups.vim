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
