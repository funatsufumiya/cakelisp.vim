fun! s:DetectCakelisp()
    if getline(1) =~# '^#!.*/bin/env\s\+cakelisp\>'
        setfiletype cakelisp
    endif
endfun

autocmd BufRead,BufNewFile *.cake setlocal filetype=cakelisp
autocmd BufNewFile,BufRead * call s:DetectCakelisp()