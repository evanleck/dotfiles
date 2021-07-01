" Trim trailing lines that are effectively empty.
"   https://stackoverflow.com/a/7496112
function! TrimTrailingEmptyLines()
  if &l:modifiable
    " don't lose user position when trimming trailing whitespace
    let s:view = winsaveview()
    try
      silent! keeppatterns %s#\($\n\s*\)\+\%$##
    finally
      call winrestview(s:view)
    endtry
  endif
endfunction
