" Vim syntax file
" Language: Basic Next (0.6)
" Maintainer: Carlos Quintella
" License: Mozilla Public License Version 2.0

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax case match

" Comments
syntax keyword basicnextTodo contained TODO FIXME XXX NOTE BUG
syntax match basicnextCommentLine "//.*$" contains=@Spell,basicnextTodo
syntax region basicnextCommentBlock start="/\*" end="\*/" contains=@Spell,basicnextTodo

" Strings and Escapes
syntax match basicnextEscape contained "\\\([\\"'nrt0]\|x[0-9a-fA-F]\{2}\)"
syntax region basicnextString start=+"+ skip=+\\"+ end=+"+ contains=basicnextEscape

" Numbers
syntax match basicnextNumber "\<0x[0-9a-fA-F]\+\>"
syntax match basicnextNumber "\<0b[01]\+\>"
syntax match basicnextFloat  "\<\d\+\.\d\+\([eE][+-]\?\d\+\)\?\>"
syntax match basicnextFloat  "\<\d\+[eE][+-]\?\d\+\>"
syntax match basicnextNumber "\<\d\+\>"

" Floating Point Constants & Literals
syntax keyword basicnextFloatConst INF NAN

" Constants & Booleans
syntax keyword basicnextBoolean TRUE FALSE
syntax keyword basicnextConstant NULL NA EOF

" Conditionals & Branches
syntax keyword basicnextConditional IF THEN ELSE
syntax keyword basicnextBranch EXIT CONTINUE RETURN STOP

" Loops
syntax keyword basicnextRepeat WHILE FOR TO STEP EACH IN REPEAT UNTIL

" Async / Await
syntax keyword basicnextAsync AWAIT

" End constructs
syntax match basicnextEnd "\<END\s\+\(FUNCTION\|WHILE\|IF\|FOR\|CLASS\|STRUCT\|INTERFACE\|CONSTRUCTOR\|DESTRUCTOR\)\>"
syntax keyword basicnextEnd END

" Declarations & Modifiers
syntax keyword basicnextDeclaration LET CONST STATIC PUBLIC PRIVATE PROTECTED OVERRIDE
syntax keyword basicnextDeclaration EXTENDS IMPLEMENTS IMPORT EXPORT AS IS WEAK RELEASE

" Structure & Object Definitions
syntax keyword basicnextStructure CLASS STRUCT INTERFACE
syntax keyword basicnextFunction FUNCTION CONSTRUCTOR DESTRUCTOR ASYNC
syntax keyword basicnextOperator NEW

" Identifiers & Self
syntax keyword basicnextSelf SELF SUPER

" Builtin functions & Host
syntax keyword basicnextBuiltin PRINT INPUT LEN SIZEOF HOST

" Operators (textual and symbolic)
syntax keyword basicnextOperator AND OR NOT XOR SHL SHR DIV
syntax match basicnextOperator "[+\-*/^%=]\|<>\|<=\|>=\|<\|>\|++\|--"

" Types
syntax keyword basicnextType BYTE INT8 INT16 INT32 INT64 UINT16 UINT32 UINT64
syntax keyword basicnextType INTEGER FLOAT32 FLOAT64 FLOAT TIMESTAMP DATE TIME TIMEZONE
syntax keyword basicnextType STRING BOOLEAN VOID POINTER

" Purged / Deprecated keywords
syntax keyword basicnextDeprecated DELETE

" Reserved future keywords
syntax keyword basicnextReserved PARALLEL SYSTEM

" Highlight mappings
highlight default link basicnextCommentLine   Comment
highlight default link basicnextCommentBlock  Comment
highlight default link basicnextTodo          Todo
highlight default link basicnextString        String
highlight default link basicnextEscape        SpecialChar
highlight default link basicnextNumber        Number
highlight default link basicnextFloat         Float
highlight default link basicnextFloatConst    Constant
highlight default link basicnextBoolean       Boolean
highlight default link basicnextConstant      Constant
highlight default link basicnextConditional   Conditional
highlight default link basicnextRepeat        Repeat
highlight default link basicnextBranch        Keyword
highlight default link basicnextAsync         Keyword
highlight default link basicnextEnd           Keyword
highlight default link basicnextDeclaration   StorageClass
highlight default link basicnextStructure     Structure
highlight default link basicnextFunction      Function
highlight default link basicnextOperator      Operator
highlight default link basicnextBuiltin       Keyword
highlight default link basicnextSelf          Identifier
highlight default link basicnextType          Type
highlight default link basicnextDeprecated    Error
highlight default link basicnextReserved      WarningMsg

let b:current_syntax = "basicnext"

let &cpo = s:cpo_save
unlet s:cpo_save
