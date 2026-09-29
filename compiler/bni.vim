" Vim compiler file
" Compiler: Basic Next Interpreter & Frontend Validator (bni)
" Maintainer: Carlos Quintella
" License: Mozilla Public License Version 2.0

if exists("current_compiler")
  finish
endif
let current_compiler = "bni"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=bni\ check\ %:S

CompilerSet errorformat=%Eerror%*[^:]:\ %m,%Wwarning%*[^:]:\ %m,%Inote%*[^:]:\ %m,%C\ %#-->\ %f:%l:%c,%Z%^,%C%*[\ ]%m,%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
