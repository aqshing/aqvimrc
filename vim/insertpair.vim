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

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunc