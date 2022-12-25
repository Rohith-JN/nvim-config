set formatoptions-=o
set formatoptions-=r
set foldmethod=expr foldexpr=utils#VimFolds(v:lnum) foldtext=utils#MyFoldText()
set keywordprg=:help

nnoremap <buffer><silent> <F9> :source %<CR>
