" Vim indent file
" Language: Basic Next (0.6)
" Version: 0.6.0
" Maintainer: Carlos Quintella
" License: Mozilla Public License Version 2.0

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetBasicNextIndent(v:lnum)
setlocal indentkeys=o,O,0=END,0=ELSE,0=UNTIL,0=/*,0=*/,=ELSE

let s:cpo_save = &cpo
set cpo&vim

function! s:StripComment(line) abort
  let l = substitute(a:line, '//.*$', '', '')
  let l = substitute(l, '/\*.*\*/', '', '')
  return trim(l)
endfunction

function! GetBasicNextIndent(lnum) abort
  let prevlnum = prevnonblank(a:lnum - 1)
  if prevlnum == 0
    return 0
  endif

  let prevline = getline(prevlnum)
  let curline = getline(a:lnum)
  let ind = indent(prevlnum)

  let clean_prev = s:StripComment(prevline)
  let clean_cur = s:StripComment(curline)

  " Increase indent after block openers (unless closed on the same line)
  let s:block_open = '^\s*\(FUNCTION\|ASYNC\s\+FUNCTION\|WHILE\|IF\|ELSE\|FOR\|CLASS\|STRUCT\|INTERFACE\|CONSTRUCTOR\|DESTRUCTOR\|REPEAT\)\>'
  let s:block_close = '\<\(END\s\+\(FUNCTION\|WHILE\|IF\|FOR\|CLASS\|STRUCT\|INTERFACE\|CONSTRUCTOR\|DESTRUCTOR\)\|UNTIL\)\>'

  if clean_prev =~? s:block_open && clean_prev !~? s:block_close
    let ind = ind + shiftwidth()
  endif

  " Decrease indent on block closers and branch statements
  let s:cur_close = '^\s*\(END\s\+\(FUNCTION\|WHILE\|IF\|FOR\|CLASS\|STRUCT\|INTERFACE\|CONSTRUCTOR\|DESTRUCTOR\)\|ELSE\|UNTIL\)\>'
  if clean_cur =~? s:cur_close
    let ind = ind - shiftwidth()
  endif

  return ind < 0 ? 0 : ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
