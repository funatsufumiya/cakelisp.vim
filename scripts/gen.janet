# Generate real syntax file from template.

(def built-ins (filter |(not= 'built-ins $) (all-bindings)))

(def functions (filter |(not (get (dyn $) :macro)) built-ins))
(def macros (filter |(get (dyn $) :macro) built-ins))

(def template
`````
" Vim syntax file
" Language:   Cakelisp
" Maintainer: Funatsu Fumiya
" URL:        https://github.com/funatsufumiya/cakelisp.vim
" License:    MIT License

if exists("b:current_syntax")
    finish
endif

let s:cpo_sav = &cpo
set cpo&vim

if has("folding") && exists("g:cakelisp_fold") && g:cakelisp_fold > 0
    setlocal foldmethod=syntax
endif

syntax keyword CakelispCommentTodo contained FIXME XXX TODO FIXME: XXX: TODO:

" Cakelisp comments
syntax match CakelispComment ";;.*$" contains=CakelispCommentTodo,@Spell

syntax match CakelispStringEscape '\v\\%([ntvr0zfe"\\]|x[[0-9a-fA-F]]\{2}|u[[0-9a-fA-F]]\{4}|U[[0-9a-fA-F]]\{6})' contained
syntax region CakelispString matchgroup=CakelispStringDelimiter start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=CakelispStringEscape,@Spell
syntax region CakelispBuffer matchgroup=CakelispStringDelimiter start=/@"/ skip=/\\\\\|\\"/ end=/"/ contains=CakelispStringEscape,@Spell
syntax region CakelispString matchgroup=CakelispStringDelimiter start="\z(`\+\)" end="\z1" contains=@Spell
syntax region CakelispBuffer matchgroup=CakelispStringDelimiter start="@\z(`\+\)" end="\z1" contains=@Spell

let s:cakelisp_syntax_keywords = {
    \   'CakelispBoolean': ["false","true"]
    \ , 'CakelispConstant': ["nil"]
    \ , 'CakelispSpecialForm': ["if","do","fn","while","def","var","quote","quasiquote","unquote","splice","set","break"]
    \ , 'CakelispFunction': $$FUNCTIONS$$
    \ , 'CakelispMacro': $$MACROS$$
    \ }

function! s:syntax_keyword(dict)
    for key in keys(a:dict)
        execute 'syntax keyword' key join(a:dict[key], ' ')
    endfor
endfunction

call s:syntax_keyword(s:cakelisp_syntax_keywords)

unlet! s:key
delfunction s:syntax_keyword

" Try symchars but handle old vim versions.
try
    let s:symcharnodig = '\!\$%\&\*\+\-./:<=>?@A-Z^_a-z|\x80-\U10FFFF'
    " Make sure we support large character ranges in this vim version.
    execute 'syntax match CakelispSymbolDud "\v<%([' . s:symcharnodig . '])%([' . s:symchar . '])*>"'
catch
    let s:symcharnodig = '\!\$%\&\*\+\-./:<=>?@A-Z^_a-z'
endtry

" Cakelisp special characters
syntax match CakelispQuote "'"
" syntax match CakelispSplice ";"
syntax match CakelispQuasiquote "\~"
syntax match CakelispUnquote ","
syntax match CakelispShortFn "|"

" Cakelisp symbols
let s:symchar = '0-9' . s:symcharnodig
execute 'syntax match CakelispSymbol "\v<%([' . s:symcharnodig . '])%([' . s:symchar . '])*>"'
execute 'syntax match CakelispKeyword "\v<:%([' . s:symchar . '])*>"'
execute 'syntax match CakelispQuoted "\v' . "'" . '<%([' . s:symcharnodig . '])%([' . s:symchar . '])*>"'
unlet! s:symchar s:symcharnodig

" Cakelisp numbers
function! s:syntaxNumber(prefix, expo, digit)
  let l:digit = '[_' . a:digit . ']'
  execute 'syntax match CakelispNumber "\v\c<[-+]?' . a:prefix . '%(' .
              \ l:digit . '+|' .
              \ l:digit . '+\.' . l:digit . '*|' .
              \ '\.' . l:digit . '+)%(' . a:expo . '[-+]?[' . a:digit . ']+)?>"'
endfunction
let s:radix_chars = "0123456789abcdefghijklmnopqrstuvwxyz"
for s:radix in range(2, 36)
    call s:syntaxNumber(s:radix . 'r', '\&', '[' . strpart(s:radix_chars, 0, s:radix) . ']')
endfor
call s:syntaxNumber('', '[&e]', '0123456789')
call s:syntaxNumber('0x', '\&', '0123456789abcdef')
unlet! s:radix_chars s:radix

" -*- TOP CLUSTER -*-
syntax cluster CakelispTop contains=@Spell,CakelispComment,CakelispConstant,CakelispQuoted,CakelispKeyword,CakelispSymbol,CakelispNumber,CakelispString,CakelispBuffer,CakelispTuple,CakelispArray,CakelispTable,CakelispStruct,CakelispSpecialForm,CakelispBoolean,CakelispFunction,CakelispMacro

syntax region CakelispTuple matchgroup=CakelispParen start="("  end=")" contains=@CakelispTop fold
syntax region CakelispArray matchgroup=CakelispParen start="@("  end=")" contains=@CakelispTop fold
syntax region CakelispTuple matchgroup=CakelispParen start="\[" end="]" contains=@CakelispTop fold
syntax region CakelispArray matchgroup=CakelispParen start="@\[" end="]" contains=@CakelispTop fold
syntax region CakelispTable matchgroup=CakelispParen start="{"  end="}" contains=@CakelispTop fold
syntax region CakelispStruct matchgroup=CakelispParen start="@{"  end="}" contains=@CakelispTop fold

" Highlight superfluous closing parens, brackets and braces.
syntax match CakelispError "]\|}\|)"

syntax sync fromstart

" Highlighting
hi def link CakelispComment Comment
hi def link CakelispSymbol Normal
hi def link CakelispQuoted Identifier
hi def link CakelispNumber Number
hi def link CakelispConstant Constant
hi def link CakelispBoolean Boolean
hi def link CakelispKeyword Keyword
hi def link CakelispSpecialForm Special
hi def link CakelispFunction Function
hi def link CakelispMacro Macro
hi def link CakelispBuffer String
hi def link CakelispString String
hi def link CakelispStringDelimiter String
hi def link CakelispStringEscape Character
hi def link CakelispQuote SpecialChar
" hi def link CakelispSplice SpecialChar
hi def link CakelispQuasiquote SpecialChar
hi def link CakelispUnquote SpecialChar
hi def link CakelispShortFn SpecialChar
hi def link CakelispParen Delimiter
hi def link CakelispError Error

let b:current_syntax = "cakelisp"

let &cpo = s:cpo_sav
unlet! s:cpo_sav
`````)

(->> template
    (string/replace "$$FUNCTIONS$$" (string "[\"" (string/join functions "\",\"") "\"]"))
    (string/replace "$$MACROS$$" (string "[\"" (string/join macros "\",\"") "\"]"))
    (spit "syntax/cakelisp.vim"))
