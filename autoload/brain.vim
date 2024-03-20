" brain files
nmap <space>e "ayi':<C-r>a<CR>lh

" Finds a file and returns the path. Using some 'smart' path expanding if no
" absolute pathname is used.
let g:brain_lnk_dir_search_list = $BRAIN_DIR_LIST_HOME_REL
fu! BrainFindFile(file)
  let target = a:file
  if target =~? '^\/'
    return target
  endif
  if filereadable("./" . target)
    return "./" . target
  endif
  let dirs = split(g:brain_lnk_dir_search_list, ',')
  if len(dirs) == 0
    return $HOME . target
  endif
  for i in dirs
    if filereadable($HOME . '/' . i . '/' . target)
      return $HOME . '/' . i . '/' . target
    endi
  endfo
  return target
endf

fu! BrainBackgroundProcNoStderr(proc, ...)
  let args = a:000
  if type(args[0]) == 3
    let args = args[0]
  endif
  let cmd = "!".a:proc." " . join(args, " ") . " 2>/dev/null &"
  "echoerr cmd
  exec cmd
endfu
fu! BrainImg_(file)
  call BrainBackgroundProcNoStderr("eog", BrainFindFile(a:file))
endfu
fu! BrainPdf_(...)
  call BrainBackgroundProcNoStderr("evince", BrainFindFile(a:000))
endfu
com! -nargs=1 Img call BrainImg_(<f-args>)
com! -nargs=+ Pdf call BrainPdf_(<f-args>)

fu! BrainTabTmpReadCmd(...)
  exec "normal :tabe\<CR>"
  nmap <buffer> q :q!<CR>
  exec "normal :r !".join(a:000, " ")."\<CR>"
  normal ggdd
  exec "TabooRename ".a:1
endfu
com! -nargs=* TabTmp call BrainTabTmpReadCmd(<f-args>)

" show sections & headlines
fu! BrainGrepHelpContent_(...)
  let verbose = 0
  let exe_init = "normal o\<ESC>mt"
  let exe_str             = "r !grep -E -no \"^[A-Z][A-Z0-9 -]+ \\*\" %"
  let exe_str_verbose     = "r !grep -E -no \"(^[A-Z][A-Z0-9 -]+ \\*|^=== .* ===)\" %"
  let exe_str_veryverbose = "r !grep -E -no \"(^[A-Z][A-Z0-9 -]+ \\*|^=== .* ===|^.*\~$)\" %"
  let exe_finalize = "normal V't>.gv:s/:/    /g\<CR>'t"
  if len(a:000) > 0 | let verbose = a:000[0] | endif
  if verbose == 1 | let exe_str = exe_str_verbose | endif
  if verbose == 2 | let exe_str = exe_str_veryverbose | endif
  exe exe_init
  exe exe_str
  exe exe_finalize
endfu
com! -nargs=? GrepHelpContent :call BrainGrepHelpContent_(<f-args>)
com! -nargs=0 Content :call BrainGrepHelpContent_(1)
com! -nargs=0 ContentVerbose :call BrainGrepHelpContent_(2)
com! -nargs=0 ContentShort :call BrainGrepHelpContent_()

" search through whole brain (zsh specific) TODO: does not work properly |-(
"com! -nargs=* GrepBrain :grep -I --exclude='*~' --exclude='*.swp' <args> $(cd;dirs=(${BRAIN_DIR_LIST_HOME_REL//,/ });find $dirs   -name '*.lang' -or -name 'lang.*')

" linking to files
fu! BrainGotoHeadl(hdl)
  exe "normal /".a:hdl."\<CR>zt\<C-n>"
endf
fu! BrainLnk(file, ...)
  let target = BrainFindFile(a:file)
  exe g:lnk_open_cmd." ".target
  if a:0 == 1
    call BrainGotoHeadl(a:1)
  elseif a:0 > 1
    echoerr "wtf, too manny args: ".a:000
    exe "normal :q\<CR>"
    return -1
  endif
  if g:lnk_after_cmd != ""
    exe g:lnk_after_cmd
  endif
  return 0
endf
fu! BrainLnkDoTab()
  let g:lnk_open_cmd = "tabe"
  let g:lnk_after_cmd = ""
endfu
fu! BrainLnkDoVSplit()
  let g:lnk_open_cmd = "vsplit"
  let g:lnk_after_cmd = "normal \<C-w>L"
endfu
call BrainLnkDoTab() " default is tab
com! -nargs=+ Lnk call BrainLnk(<f-args>)
com! -nargs=0 LnkDoVSplit call BrainLnkDoVSplit()
com! -nargs=0 LnkDoTab call BrainLnkDoTab()

" Sourcing vim files
fu! BrainSrc(file)
  let target = BrainFindFile(a:file)
  exec 'normal tabe'
  exec 'source '.target
endf
com! -nargs=1 Src tabe | call BrainSrc(<f-args>)

let g:brain_session_dir = join([$HOME, '0x/vim'], '/')
fu! _Mkbrain(...)
  let file = ""
  if a:0 == 1
    let file = a:1
  endif
  let session = join([g:brain_session_dir, file], '/')
  if file == ""
    let session = v:this_session
  endif
  if session == ""
    echoerr "empty default session! either name a session or use `mksess` yourself"
    return 1
  endif
  exec 'mksess! ' . session
endfu
fu! _MkbrainComplete(prefix, ...)
  let all = split(system('ls ' . g:brain_session_dir), '\n')
  let filtered = filter(all, 'v:val =~ "^'.a:prefix.'"')
  return filtered
  "return sort(filtered, '_MkbrainSortSmallestFirst')
endfu
"fu! _MkbrainSortSmallestFirst(i1, i2)
"  return len(a:i1) > len(a:i2)
"endfu
com! -nargs=? -complete=customlist,_MkbrainComplete Mkbrain call _Mkbrain(<f-args>)

fu! brain#brain()
endfu
