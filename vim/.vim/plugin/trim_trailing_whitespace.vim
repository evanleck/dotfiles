" Thank you, editorconfig.
"   https://github.com/editorconfig/editorconfig-vim/blob/master/plugin/editorconfig.vim
function! TrimTrailingWhitespace()
  if &l:modifiable
    " don't lose user position when trimming trailing whitespace
    let s:view = winsaveview()
    try
      silent! keeppatterns %s/\s\+$//e
    finally
      call winrestview(s:view)
    endtry
  endif
endfunction
