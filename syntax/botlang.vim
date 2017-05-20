" Vim syntax file
"      Language: botlang
"       Version: 0.1.0
"    Maintainer: Mathias Schilling <m@matchilling.com>
"       License: GPL-3.0
" Last Modified: Sat 20 May 15:44:10 UTC 2017
"    Repository: https://github.com/botlang/vim-language-botlang
"          Bugs: https://github.com/botlang/vim-language-botlang/issues

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax") " Checks whether an earlier file has defined a syntax already
    finish
  endif
  let main_syntax = 'botlang'
endif

syntax sync fromstart

" Statement Keywords {{{
syntax region  botlangMutiple       start='(' skip=+\\\\\|\\"+ end=')' contains=botlangMutipleString
syntax match   botlangMutipleString "[a-zA-Z0-9\\'\\s\\-]*"
syntax match   botlangSubstitution  "\$"
syntax match   botlangWildcard      "\*"

syntax match   botlangTrigger       "^\s*+\s*" nextgroup=botlangTriggerTxt contains=@NoSpell
syntax region  botlangTriggerTxt    start='"' end='"' contained contains=botlangMutiple,botlangSubstitution,botlangWildcard

syntax match   botlangReply         "^\s*-\s*" nextgroup=botlangReplyTxt contains=@NoSpell
syntax region  botlangReplyTxt      start='"' end='"' contained contains=botlangMutiple,botlangSubstitution,botlangWildcard
"}}}
" Comments {{{
syntax keyword botlangCommentTodo   contained TODO FIXME NOTE
syntax match   botlangLineComment   "#.*$" contains=botlangCommentTodo
"}}}
" Strings {{{
syntax region  botlangString        start=+"+  skip=+\\\\\|\\"+  end=+"\|$+
"}}}
" Highlight links {{{
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_botlang_syn_inits")
  if version < 508
    let did_botlang_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink botlangMutiple       Special
  HiLink botlangSubstitution  Function
  HiLink botlangWildcard      Function

  HiLink botlangLineComment   Comment
  HiLink botlangCommentTodo   Todo

  HiLink botlangMutipleString Special
	HiLink botlangReplyTxt      String
  HiLink botlangString        String
  HiLink botlangTriggerTxt    String

  HiLink botlangTrigger       Operator
  HiLink botlangReply         Operator

  delcommand HiLink
endif
" end Highlight links }}}

let b:current_syntax = "botlang"
if main_syntax == 'botlang'
  unlet main_syntax
endif
