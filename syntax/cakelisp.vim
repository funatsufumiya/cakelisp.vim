" Vim syntax file
" Language:   Cakelisp
" Maintainer: Funatsu Fumiya
" URL:        https://github.com/funatsufumiya/cakelisp.vim
" License:    MIT License

" =============
"     NOTE
" =============
"
" - - - - - - - - - - - - -
"
" This file is AUTO GENERATED. Do not edit this directly.
"
" - - - - - - - - - - - - -


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
"syntax region CakelispBuffer matchgroup=CakelispStringDelimiter start=/@"/ skip=/\\\\\|\\"/ end=/"/ contains=CakelispStringEscape,@Spell
"syntax region CakelispString matchgroup=CakelispStringDelimiter start="\z(`\+\)" end="\z1" contains=@Spell
"syntax region CakelispBuffer matchgroup=CakelispStringDelimiter start="@\z(`\+\)" end="\z1" contains=@Spell

let s:cakelisp_syntax_keywords = {
    \   'CakelispBoolean': ["false","true"]
    \ , 'CakelispConstant': ["null"]
    \ , 'CakelispSpecialForm': ["char","void","int","bool","unsigned","signed","alias","template","bundle-file","export-and-evaluate","skip-build","comptime-define-symbol","set-cakelisp-option","set-fields","ignore","break","comptime-error","def","defun","defun-nodecl","defun-local","defun-comptime","def-task","def-c-function-alias","def-introspect-struct","def-versioned-struct","def-function-signature","def-function-signature-global","ref","deref","def-type-alias","def-type-alias-global","incr","decr","addr","at","for-in","call-on","call-on-ptr","?","!=","type-cast","field","scope","defun-comptime","c-import","c-for","tokenize-push","token-splice","token-splice-rest","token-splice-addr","token-splice-array","comptime-cond","c-preprocessor-define","array-size","each-in-range","each-in-array","each-item-in-array","each-item-addr-in-array","forward-declare","continue","do","var","var-global","var-static","var-cast-to","const","set","while","if","export","dict-free","dict-free-void","dict-set-struct","dict-ptr-at","dict-length","&return","&rest","or","and","quote","quasiquote","unquote","splice","%","%=","*","*=","+","++","+=","-","--","-=","->","->>","-?>","-?>>","/","/=","<","<=","=",">",">=","abstract?","accumulate","accumulate2","all","all-bindings","all-dynamics","and","any?","apply","array","assert","bit-or","bit-and","bit-xor","bit-not","bit-shift->>","bit-shift-<<","block","buffer","cancel","case","cmp","comment","comptime","compwhen","cond","coro","count","curenv","debugger-env","dec","deep-not=","deep=","def-","default","default-peg-grammar","defer","defglobal","defmacro","defmacro-","defgenerator","defenum","defenum-local","defenum-and-string-table","defstruct","defstruct-local","defcommand","describe","dictionary?","disasm","distinct","doc","doc*","doc-format","dofile","drop","each","empty?","error","errorf","eval","eval-string","even?","every?","extreme","false?","filter","find","first","flatten","flush","for","forever","forv","freeze","frequencies","function?","fprintf","free","fclose","fwrite","fopen","gccollect","gcinterval","gcsetinterval","generate","gensym","get","get-in","get-or-create-comptime-var","getline","hash","idempotent?","identity","if-let","if-not","if-with","import","import*","in","inc","index-of","indexed?","int/s64","int/u64","int?","interleave","interpose","invert","keep","keys","keyword","kvs","label","last","length","let","loop","macex","macex1","map","mapcat","marshal","match","negate","path","partial","partition","prinf","print","printf","product","prompt","propagate","protect","put","quit","range","reduce","reduce2","repeat","repl","require","resume","return","reverse","reverse!","root-env","run-context","scan-number","seq","setdyn","short-fn","signal","slice","slurp","some","sort","sort-by","sorted","sorted-by","spit","stderr","stdin","stdout","string","struct","struct?","size_t","sizeof","sum","table","take","trace","tracev","true?","truthy?","try","tuple","type","unless","unmarshal","untrace","update","update-in","use","values","va_start","va_end","var-","varfn","varglobal","walk","when","when-let","when-with","with","with-dyns","with-syms","with-vars","xprin","yield","zero?","zipcoll"]
    \ , 'CakelispFunction': ["sprintf","memcpy","malloc","xprinf","xprint","xprintf"]
    \ , 'CakelispMacro': ["add-compile-time-hook","add-compile-time-hook-module","add-cakelisp-search-directory","add-c-search-directory-module","add-c-build-dependency","add-cpp-build-dependency","add-static-link-objects","add-library-dependency","add-library-search-directory","add-library-runtime-search-directory","add-dependency-git-submodule","add-dependency-git-submodule-at-commit","add-compiler-link-options","add-linker-options","add-build-options","add-build-config-label","add-c-search-directory-global","declare-external","declare-extern-function"]
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
"syntax match CakelispSplice ";"
"syntax match CakelispQuasiquote "\~"
"syntax match CakelispUnquote ","
"syntax match CakelispShortFn "|"

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
              \ '\.' . l:digit . '+)%(' . a:expo . '[-+]?[' . a:digit . ']+)?f?>"'
endfunction
let s:radix_chars = "0123456789abcdefghijklmnopqrstuvwxyz"
for s:radix in range(2, 36)
    call s:syntaxNumber(s:radix . 'r', '\&', '[' . strpart(s:radix_chars, 0, s:radix) . ']')
endfor
call s:syntaxNumber('', '[&e]', '0123456789')
call s:syntaxNumber('0x', '\&', '0123456789abcdef')
unlet! s:radix_chars s:radix

" -*- TOP CLUSTER -*-
syntax cluster CakelispTop contains=@Spell,CakelispComment,CakelispConstant,CakelispQuoted,CakelispKeyword,CakelispSymbol,CakelispNumber,CakelispString,CakelispTuple,CakelispTable,CakelispSpecialForm,CakelispBoolean,CakelispFunction,CakelispMacro

syntax region CakelispTuple matchgroup=CakelispParen start="("  end=")" contains=@CakelispTop fold
"syntax region CakelispArray matchgroup=CakelispParen start="@("  end=")" contains=@CakelispTop fold
syntax region CakelispTuple matchgroup=CakelispParen start="\[" end="]" contains=@CakelispTop fold
"syntax region CakelispArray matchgroup=CakelispParen start="@\[" end="]" contains=@CakelispTop fold
syntax region CakelispTable matchgroup=CakelispParen start="{"  end="}" contains=@CakelispTop fold
"syntax region CakelispStruct matchgroup=CakelispParen start="@{"  end="}" contains=@CakelispTop fold

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
"hi def link CakelispBuffer String
hi def link CakelispString String
hi def link CakelispStringDelimiter String
hi def link CakelispStringEscape Character
hi def link CakelispQuote SpecialChar
"hi def link CakelispSplice SpecialChar
"hi def link CakelispQuasiquote SpecialChar
"hi def link CakelispUnquote SpecialChar
"hi def link CakelispShortFn SpecialChar
hi def link CakelispParen Delimiter
hi def link CakelispError Error

let b:current_syntax = "cakelisp"

let &cpo = s:cpo_sav
unlet! s:cpo_sav