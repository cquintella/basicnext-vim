" Basic Next Autoload Helper
" Language: Basic Next (0.6)
" Version: 0.6.0
" Maintainer: Carlos Quintella
" License: Mozilla Public License Version 2.0

let s:cpo_save = &cpo
set cpo&vim

" Canonical Basic Next 0.6 reserved words, types and commands in ALLCAPS
let g:basicnext#keywords = [
      \ 'AND', 'AS', 'ASYNC', 'AWAIT', 'BOOLEAN', 'BYTE', 'CLASS', 'CONST',
      \ 'CONSTRUCTOR', 'CONTINUE', 'DATE', 'DESTRUCTOR', 'DIV', 'EACH', 'ELSE',
      \ 'END', 'EOF', 'EXIT', 'EXPORT', 'EXTENDS', 'FALSE', 'FLOAT', 'FLOAT32',
      \ 'FLOAT64', 'FOR', 'FUNCTION', 'HOST', 'IF', 'IMPLEMENTS', 'IMPORT', 'IN',
      \ 'INPUT', 'INT8', 'INT16', 'INT32', 'INT64', 'INTEGER', 'INTERFACE', 'IS',
      \ 'LEN', 'LET', 'NA', 'NAN', 'INF', 'NEW', 'NOT', 'NULL', 'OR', 'OVERRIDE',
      \ 'PARALLEL', 'POINTER', 'PRINT', 'PRIVATE', 'PROTECTED', 'PUBLIC', 'RELEASE',
      \ 'REPEAT', 'RETURN', 'SELF', 'SHL', 'SHR', 'SIZEOF', 'STATIC', 'STEP',
      \ 'STOP', 'STRING', 'STRUCT', 'SUPER', 'SYSTEM', 'THEN', 'TIME', 'TIMESTAMP',
      \ 'TIMEZONE', 'TO', 'TRUE', 'UINT16', 'UINT32', 'UINT64', 'UNTIL', 'VOID',
      \ 'WEAK', 'WHILE', 'XOR'
      \ ]

let s:kw_dict = {}
for s:w in g:basicnext#keywords
  let s:kw_dict[tolower(s:w)] = s:w
endfor

""
" Omnifunc completion for Basic Next
" Completes keywords in ALLCAPS regardless of typed case
function! basicnext#Complete(findstart, base) abort
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~# '\k'
      let start -= 1
    endwhile
    return start
  else
    let res = []
    let lbase = tolower(a:base)
    for kw in g:basicnext#keywords
      if tolower(kw) =~# '^' . lbase
        call add(res, {'word': kw, 'menu': '[BN]'})
      endif
    endfor
    return res
  endif
endfunction

""
" Setup buffer-local abbreviations to auto-capitalize reserved words when typed
function! basicnext#SetupAutoCaps() abort
  for kw in g:basicnext#keywords
    let lkw = tolower(kw)
    " Do not self-abbreviate if already identical
    if lkw !=# kw
      execute 'silent! iabbrev <buffer> ' . lkw . ' ' . kw
    endif
  endfor
endfunction

""
" Formats a single line of Basic Next code:
" - Uppercases reserved words outside strings and comments
" - Normalizes `END   KEYWORD` to `END KEYWORD`
function! s:FormatLine(line) abort
  let len = strlen(a:line)
  let out = ''
  let i = 0
  let in_string = 0

  while i < len
    let ch = a:line[i]

    " Line comment: rest of the line is unchanged
    if !in_string && ch ==# '/' && i + 1 < len && a:line[i + 1] ==# '/'
      let out .= strpart(a:line, i)
      break
    endif

    " String literal handling
    if ch ==# '"'
      if in_string
        " Check for escaped quote \"
        let backslashes = 0
        let k = i - 1
        while k >= 0 && a:line[k] ==# '\'
          let backslashes += 1
          let k -= 1
        endwhile
        if backslashes % 2 == 0
          let in_string = 0
        endif
      else
        let in_string = 1
      endif
      let out .= ch
      let i += 1
      continue
    endif

    if in_string
      let out .= ch
      let i += 1
      continue
    endif

    " Word extraction outside strings
    if ch =~# '[a-zA-Z_]'
      let start = i
      while i < len && a:line[i] =~# '[a-zA-Z0-9_]'
        let i += 1
      endwhile
      let word = strpart(a:line, start, i - start)
      let lword = tolower(word)

      " If this is an 'END' word, check if followed by block keyword
      if lword ==# 'end'
        " Look ahead for whitespace and next word
        let j = i
        while j < len && a:line[j] =~# '[ \t]'
          let j += 1
        endwhile
        if j > i && j < len && a:line[j] =~# '[a-zA-Z_]'
          let nstart = j
          while j < len && a:line[j] =~# '[a-zA-Z0-9_]'
            let j += 1
          endwhile
          let next_word = strpart(a:line, nstart, j - nstart)
          let lnext = tolower(next_word)
          if has_key(s:kw_dict, lnext)
            let out .= 'END ' . s:kw_dict[lnext]
            let i = j
            continue
          endif
        endif
      endif

      if has_key(s:kw_dict, lword)
        let out .= s:kw_dict[lword]
      else
        let out .= word
      endif
      continue
    endif

    let out .= ch
    let i += 1
  endwhile

  return out
endfunction

""
" Format the buffer or range:
" - Uppercases keywords outside comments and strings
" - Normalizes block closers
" - Reindents code cleanly
function! basicnext#Format() abort
  let view = winsaveview()
  let total = line('$')

  let lines = []
  for lnum in range(1, total)
    call add(lines, s:FormatLine(getline(lnum)))
  endfor
  call setline(1, lines)

  " Reindent whole buffer using indent/basicnext.vim
  silent! normal! gg=G

  call winrestview(view)
endfunction

""
" Formatexpr hook for Vim's 'gq' operator
function! basicnext#FormatExpr() abort
  if mode() =~# '[iR]'
    return 1
  endif
  let start = v:lnum
  let end = v:lnum + v:count - 1

  let lines = []
  for lnum in range(start, end)
    call add(lines, s:FormatLine(getline(lnum)))
  endfor
  call setline(start, lines)

  " Reindent the formatted range
  execute 'silent! ' . start . ',' . end . 'normal! =='
  return 0
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
