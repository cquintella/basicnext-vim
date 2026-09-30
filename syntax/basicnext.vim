" Vim syntax file
" Language: Basic Next (0.6)
" Version: 0.6.0
" Maintainer: Carlos Quintella
" License: Mozilla Public License Version 2.0

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax case match

" 1. General Identifiers and Variable Names (Yellow)
" Lower precedence than keywords; matches all variable/symbol names
syntax match basicnextIdentifier "\<[a-zA-Z_][a-zA-Z0-9_]*\>"

" Special object references
syntax keyword basicnextSelf SELF SUPER

" 2. Commands, Declarations and Flow Controls (Green)
syntax keyword basicnextCommand PRINT INPUT LEN SIZEOF HOST
syntax keyword basicnextCommand LET CONST STATIC PUBLIC PRIVATE PROTECTED OVERRIDE
syntax keyword basicnextCommand EXTENDS IMPLEMENTS IMPORT EXPORT AS IS WEAK RELEASE NEW
syntax keyword basicnextCommand IF THEN ELSE
syntax keyword basicnextCommand EXIT CONTINUE RETURN STOP AWAIT
syntax match   basicnextCommand "\<END\s\+IF\>"

" 3. Loops and Iteration (Orange)
syntax keyword basicnextLoop WHILE FOR TO STEP EACH IN REPEAT UNTIL
syntax match   basicnextLoop "\<END\s\+\(WHILE\|FOR\|REPEAT\)\>"

" 4. Types (Blue / Cyan - distinct from commands)
syntax keyword basicnextType BYTE INT8 INT16 INT32 INT64 UINT16 UINT32 UINT64
syntax keyword basicnextType INTEGER FLOAT32 FLOAT64 FLOAT TIMESTAMP DATE TIME TIMEZONE
syntax keyword basicnextType STRING BOOLEAN VOID POINTER

" 5. Structural Definitions and Functions (Lilac / Magenta)
syntax keyword basicnextStructure CLASS STRUCT INTERFACE
syntax keyword basicnextStructure FUNCTION CONSTRUCTOR DESTRUCTOR ASYNC
syntax match   basicnextStructure "\<END\s\+\(FUNCTION\|CONSTRUCTOR\|DESTRUCTOR\|CLASS\|STRUCT\|INTERFACE\)\>"

" 6. Strings and Character Escapes (Red)
syntax match basicnextEscape contained "\\\([\\"'nrt0]\|x[0-9a-fA-F]\{2}\)"
syntax region basicnextString start=+"+ skip=+\\"+ end=+"+ contains=basicnextEscape

" 7. Numbers, Constants and Booleans (Dark Yellow)
syntax match basicnextNumber "\<0x[0-9a-fA-F]\+\>"
syntax match basicnextNumber "\<0b[01]\+\>"
syntax match basicnextNumber "\<\d\+\.\d\+\([eE][+-]\?\d\+\)\?\>"
syntax match basicnextNumber "\<\d\+[eE][+-]\?\d\+\>"
syntax match basicnextNumber "\<\d\+\>"
syntax keyword basicnextConstant TRUE FALSE NULL NA EOF INF NAN

" 8. Operators (Cyan / Blue)
syntax keyword basicnextOperator AND OR NOT XOR SHL SHR DIV
syntax match basicnextOperator "[+\-*/^%=]\|<>\|<=\|>=\|<\|>\|++\|--"

" 9. Comments (Gray)
syntax keyword basicnextTodo contained TODO FIXME XXX NOTE BUG
syntax match basicnextComment "//.*$" contains=@Spell,basicnextTodo
syntax region basicnextComment start="/\*" end="\*/" contains=@Spell,basicnextTodo

" 10. Deprecated / Purged Keywords (Error Highlight)
syntax keyword basicnextDeprecated DELETE

" 11. Reserved for Future (Warning Highlight)
syntax keyword basicnextReserved PARALLEL SYSTEM

" --- Color Palette Mapping ---
" Commands in Green
highlight default basicnextCommand    ctermfg=Green      guifg=#98C379 gui=bold

" Loops in Orange
highlight default basicnextLoop       ctermfg=173        guifg=#D19A66 gui=bold

" Variable and identifier names in Yellow
highlight default basicnextIdentifier ctermfg=Yellow     guifg=#E5C07B
highlight default basicnextSelf       ctermfg=Yellow     guifg=#E5C07B gui=italic

" Variable Types in Blue / Cyan (distinct from commands)
highlight default basicnextType       ctermfg=Cyan       guifg=#61AFEF gui=bold

" Strings in Red
highlight default basicnextString     ctermfg=Red        guifg=#E06C75
highlight default basicnextEscape     ctermfg=LightRed   guifg=#FFA0A0

" Definitions, Functions and Structures in Lilac / Magenta
highlight default basicnextStructure  ctermfg=Magenta    guifg=#C678DD gui=bold

" Constants, Numbers and Booleans in Dark Yellow
highlight default basicnextNumber     ctermfg=DarkYellow guifg=#C49B24
highlight default basicnextConstant   ctermfg=DarkYellow guifg=#C49B24 gui=bold

" Operators in Cyan / Light Blue
highlight default basicnextOperator   ctermfg=LightBlue  guifg=#56B6C2

" Comments in Gray
highlight default basicnextComment    ctermfg=DarkGray   guifg=#7F848E gui=italic
highlight default basicnextTodo       ctermfg=Yellow     ctermbg=DarkBlue guifg=#E5C07B guibg=#282C34 gui=bold

" Errors and Deprecations
highlight default basicnextDeprecated ctermfg=White      ctermbg=Red guifg=#FFFFFF guibg=#E06C75 gui=bold
highlight default basicnextReserved   ctermfg=Black      ctermbg=Yellow guifg=#000000 guibg=#E5C07B

" Fallback links to standard syntax groups
highlight default link basicnextCommand    Statement
highlight default link basicnextLoop       Repeat
highlight default link basicnextIdentifier Identifier
highlight default link basicnextSelf       Special
highlight default link basicnextType       Type
highlight default link basicnextString     String
highlight default link basicnextEscape     SpecialChar
highlight default link basicnextStructure  Structure
highlight default link basicnextNumber     Number
highlight default link basicnextConstant   Constant
highlight default link basicnextOperator   Operator
highlight default link basicnextComment    Comment
highlight default link basicnextTodo       Todo
highlight default link basicnextDeprecated Error
highlight default link basicnextReserved   WarningMsg

let b:current_syntax = "basicnext"

let &cpo = s:cpo_save
unlet s:cpo_save
