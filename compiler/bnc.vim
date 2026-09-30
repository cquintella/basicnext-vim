" Vim compiler file
" Compiler: Basic Next Native Compiler (bnc)
" Version: 0.6.0
" Maintainer: Carlos Quintella
" License: Mozilla Public License Version 2.0

if exists("current_compiler")
  finish
endif
let current_compiler = "bnc"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=bnc\ %:S

CompilerSet errorformat=%Eerror%*[^:]:\ %m,%Wwarning%*[^:]:\ %m,%Inote%*[^:]:\ %m,%C\ %#-->\ %f:%l:%c,%Z%^,%C%*[\ ]%m,%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
