" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match helpHeadline          "^[-A-Z0-9_.][-A-Z0-9 .()_]*\ze\(\s\+\*\|$\)"
syn match helpSectionDelim      "^===.*===$"
syn match helpSectionDelim      "^---.*--$"
if has("ebcdic")
  syn match helpHyperTextJump   "\\\@<!|[^"*|]\+|" contains=helpBar
  syn match helpHyperTextEntry  "\*[^"*|]\+\*\s"he=e-1 contains=helpStar
  syn match helpHyperTextEntry  "\*[^"*|]\+\*$" contains=helpStar
else
  syn match helpHyperTextJump   "\\\@<!|[#-)!+-~]\+|" contains=helpBar
  syn match helpHyperTextEntry  "\*[#-)!+-~]\+\*\s"he=e-1 contains=helpStar
  syn match helpHyperTextEntry  "\*[#-)!+-~]\+\*$" contains=helpStar
endif
syn match helpNormal            "|.*====*|"
syn match helpNormal            "|||"
syn match helpNormal            ":|vim:|"       " for :help modeline
syn match helpVim               "\<Vim version [0-9][0-9.a-z]*"
syn match helpVim               "VIM REFERENCE.*"
syn match helpOption            "'[a-z]\{2,\}'"
syn match helpOption            "'t_..'"
syn match helpCommand           "`[^` \t]\+`"hs=s+1,he=e-1 contains=helpBacktick
syn match helpCommand           "\(^\|[^a-z"[]\)\zs`[^`]\+`\ze\([^a-z\t."']\|$\)"hs=s+1,he=e-1 contains=helpBacktick
syn match helpHeader            "\s*\zs.\{-}\ze\s\=\~$" nextgroup=helpIgnore
syn match helpGraphic           ".* \ze`$" nextgroup=helpIgnore
syn keyword helpNote            note Note NOTE note: Note: NOTE: Notes Notes:
syn keyword helpWarning         WARNING WARNING: Warning:
syn keyword helpDeprecated      DEPRECATED DEPRECATED: Deprecated:
" Don't highlight [converted] and others that do not have a tag
syn match helpNormal            "\[\(readonly\|fifo\|socket\|converted\|crypted\)]"

syn region helpNotVi            start="{Vi[: ]" start="{not" start="{only" end="}" contains=helpLeadBlank,helpHyperTextJump
syn match helpLeadBlank         "^\s\+" contained

" Highlight group items in their own color.
syn match helpComment           "\t[* ]Comment\t\+[a-z].*"
syn match helpConstant          "\t[* ]Constant\t\+[a-z].*"
syn match helpString            "\t[* ]String\t\+[a-z].*"
syn match helpCharacter         "\t[* ]Character\t\+[a-z].*"
syn match helpNumber            "\t[* ]Number\t\+[a-z].*"
syn match helpBoolean           "\t[* ]Boolean\t\+[a-z].*"
syn match helpFloat             "\t[* ]Float\t\+[a-z].*"
syn match helpIdentifier        "\t[* ]Identifier\t\+[a-z].*"
syn match helpFunction          "\t[* ]Function\t\+[a-z].*"
syn match helpStatement         "\t[* ]Statement\t\+[a-z].*"
syn match helpConditional       "\t[* ]Conditional\t\+[a-z].*"
syn match helpRepeat            "\t[* ]Repeat\t\+[a-z].*"
syn match helpLabel             "\t[* ]Label\t\+[a-z].*"
syn match helpOperator          "\t[* ]Operator\t\+["a-z].*"
syn match helpKeyword           "\t[* ]Keyword\t\+[a-z].*"
syn match helpException         "\t[* ]Exception\t\+[a-z].*"
syn match helpPreProc           "\t[* ]PreProc\t\+[a-z].*"
syn match helpInclude           "\t[* ]Include\t\+[a-z].*"
syn match helpDefine            "\t[* ]Define\t\+[a-z].*"
syn match helpMacro             "\t[* ]Macro\t\+[a-z].*"
syn match helpPreCondit         "\t[* ]PreCondit\t\+[a-z].*"
syn match helpType              "\t[* ]Type\t\+[a-z].*"
syn match helpStorageClass      "\t[* ]StorageClass\t\+[a-z].*"
syn match helpStructure         "\t[* ]Structure\t\+[a-z].*"
syn match helpTypedef           "\t[* ]Typedef\t\+[Aa-z].*"
syn match helpSpecial           "\t[* ]Special\t\+[a-z].*"
syn match helpSpecialChar       "\t[* ]SpecialChar\t\+[a-z].*"
syn match helpTag               "\t[* ]Tag\t\+[a-z].*"
syn match helpDelimiter         "\t[* ]Delimiter\t\+[a-z].*"
syn match helpSpecialComment    "\t[* ]SpecialComment\t\+[a-z].*"
syn match helpDebug             "\t[* ]Debug\t\+[a-z].*"
syn match helpUnderlined        "\t[* ]Underlined\t\+[a-z].*"
syn match helpError             "\t[* ]Error\t\+[a-z].*"
syn match helpTodo              "\t[* ]Todo\t\+[a-z].*"

syn match helpURL `\v<(((https?|ftp|gopher)://|(mailto|file|news):)[^'  <>"]+|(www|web|w3)[a-z0-9_-]*\.[a-z0-9._-]+\.[^'        <>"]+)[a-zA-Z0-9/]`

" Additionally load a language-specific syntax file "help_ab.vim".
let s:i = match(expand("%"), '\.\a\ax$')
if s:i > 0
  exe "runtime syntax/help_" . strpart(expand("%"), s:i + 1, 2) . ".vim"
endif

" Italian
if v:lang =~ '\<IT\>' || v:lang =~ '_IT\>' || v:lang =~? "italian"
  syn keyword helpNote          nota Nota NOTA nota: Nota: NOTA: notare Notare NOTARE notare: Notare: NOTARE:
  syn match helpSpecial         "Nma"me=e-2
  syn match helpSpecial         "Nme"me=e-2
  syn match helpSpecial         "Nmi"me=e-2
  syn match helpSpecial         "Nmo"me=e-2
  syn match helpSpecial         "\[interv.]"
  syn region helpNotVi          start="{non" start="{solo" start="{disponibile" end="}" contains=helpLeadBlank,helpHyperTextJump
endif

syn sync minlines=40


" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link helpIgnore          Ignore
hi def link helpHyperTextJump   Identifier
hi def link helpBar             Ignore
hi def link helpBacktick        Ignore
hi def link helpStar            Ignore
hi def link helpHyperTextEntry  String
hi def link helpHeadline        Statement
hi def link helpHeader          PreProc
hi def link helpSectionDelim    PreProc
hi def link helpVim             Identifier
hi def link helpCommand         Comment
hi def link helpExample         Comment
hi def link helpOption          Type
hi def link helpNotVi           Special
hi def link helpSpecial         Special
hi def link helpNote            Todo
hi def link helpWarning         Todo
hi def link helpDeprecated      Todo

hi def link helpComment         Comment
hi def link helpConstant        Constant
hi def link helpString          String
hi def link helpCharacter       Character
hi def link helpNumber          Number
hi def link helpBoolean         Boolean
hi def link helpFloat           Float
hi def link helpIdentifier      Identifier
hi def link helpFunction        Function
hi def link helpStatement       Statement
hi def link helpConditional     Conditional
hi def link helpRepeat          Repeat
hi def link helpLabel           Label
hi def link helpOperator        Operator
hi def link helpKeyword         Keyword
hi def link helpException       Exception
hi def link helpPreProc         PreProc
hi def link helpInclude         Include
hi def link helpDefine          Define
hi def link helpMacro           Macro
hi def link helpPreCondit       PreCondit
hi def link helpType            Type
hi def link helpStorageClass    StorageClass
hi def link helpStructure       Structure
hi def link helpTypedef         Typedef
hi def link helpSpecialChar     SpecialChar
hi def link helpTag             Tag
hi def link helpDelimiter       Delimiter
hi def link helpSpecialComment  SpecialComment
hi def link helpDebug           Debug
hi def link helpUnderlined      Underlined
hi def link helpError           Error
hi def link helpTodo            Todo
hi def link helpURL             String

let b:current_syntax = "help"

let &cpo = s:cpo_save
unlet s:cpo_save


" BEGIN: skep's changes
"
" More complex option highlighting. And single letter options.
" Match examples:
"   '/asd' 'cd somewhere' '-test' ...
syn match helpOption        "'[A-Za-z0-9/+-]\{1,30\}\([-_]\?[/A-Za-z]*\)*'"
" And stuff in {}-blocks
syn match helpSpecial       "{[-a-zA-Z0-9'"*+/:%#=[\]<>.,_]\+}"
" And stuff in []-options
syn match helpSpecial       "\s\[[-a-z^A-Z0-9_?]\{2,}]"ms=s+1

syn match helpVim "'\(![a-z]\+\|tabe\|call\|Lnk\|Doc\|Src\|\/\|Man\|Img\|r\(ead\)\?\|Pdf\|Epub\) .\{-}\( &\)\?'"
syn match helpVim "'\(\/\|?\).\{-}'"

syn clear helpHyperTextJump
syn clear helpBar

" This is for accents on letters between * *!
syn match helpHyperTextEntry "\/\@=\*[^"*|]\+\*" contains=helpStar

" ?
syn keyword Notes Note Example
hi def link Notes CursorLine

" Enable unimportant notes, which almost completely blend out of view.
syn match DarkComment ".*\s\zs\/\/.*$"
hi DarkComment ctermfg=0

syn match htmlBold "\*\*.*\*\*" contains=hideThatPlx
syn match hideThatPlx contained "\*" conceal

" language-syntax embedding
fu! InsertEmbedding(lang)
    exe "normal O\<ESC>0C <%".a:lang."%\<ESC>}O\<ESC>i %".a:lang."%>\<ESC>"
endf
com! -nargs=1 Embed call InsertEmbedding(<f-args>)

syn match ControlFlow "\<goto\>"
syn match ControlFlow "\<return\>"
hi def link ControlFlow ModeMsg

if exists('b:current_syntax') | unlet b:current_syntax | endi
syn include @pyTop syntax/python.vim
syn region pyBlock matchgroup=DarkComment start='<%py%%\@!' end='%%\@!py%>' contains=@pyTop keepend
unlet b:current_syntax

syn include @rubyTop syntax/ruby.vim
syn region rubyBlock matchgroup=DarkComment start='<%ruby%%\@!' end='%%\@!ruby%>' contains=@rubyTop keepend
unlet b:current_syntax

syn include @cTop syntax/c.vim
syn region cBlock matchgroup=DarkComment start='<%c%%\@!' end='%%\@!c%>' contains=@cTop keepend
unlet b:current_syntax

syn include @cppTop syntax/cpp.vim
syn region cppBlock matchgroup=DarkComment start='<%cpp%%\@!' end='%%\@!cpp%>' contains=@cppTop keepend
unlet b:current_syntax

syn include @htmlTop syntax/html.vim
syn region htmlBlock matchgroup=DarkComment start='<%html%%\@!' end='%%\@!html%>' contains=@htmlTop keepend
unlet b:current_syntax

"syn include @armTop syntax/arm.vim
"syn region armBlock matchgroup=DarkComment start='<%arm%%\@!' end='%%\@!arm%>' contains=@armTop keepend
"unlet b:current_syntax

syn include @shTop syntax/sh.vim
syn region shBlock matchgroup=DarkComment start='<%sh%%\@!' end='%%\@!sh%>' contains=@shTop keepend
unlet b:current_syntax

syn include @luaTop syntax/lua.vim
syn region luaBlock matchgroup=DarkComment start='<%lua%%\@!' end='%%\@!lua%>' contains=@luaTop keepend
unlet b:current_syntax

syn include @goTop syntax/go.vim
syn region goBlock matchgroup=DarkComment start='<%go%%\@!' end='%%\@!go%>' contains=@goTop keepend
unlet b:current_syntax

syn include @nasmTop syntax/nasm.vim
syn region nasmBlock matchgroup=DarkComment start='<%nasm%%\@!' end='%%\@!nasm%>' contains=@nasmTop keepend
unlet b:current_syntax

"syn include @gasTop syntax/gas.vim
"syn region gasBlock matchgroup=DarkComment start='<%gas%%\@!' end='%%\@!gas%>' contains=@gasTop keepend
"unlet b:current_syntax

syn include @rustTop syntax/rust.vim
syn region rustBlock matchgroup=DarkComment start='<%rust%%\@!' end='%%\@!rust%>' contains=@rustTop keepend
unlet b:current_syntax

syn include @jsTop syntax/javascriptreact.vim
syn region jsBlock matchgroup=DarkComment start='<%js%%\@!' end='%%\@!js%>' contains=@jsTop keepend
unlet b:current_syntax

" enable automatic minus- and bullet-list indentation
let &formatlistpat = '^\s*\d\+[\]:.)}\t ]\s*\|^\s*[-*+]\s\+'
