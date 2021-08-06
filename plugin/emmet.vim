" `<C-q>` is a decent, less used alternative to `<C-y>` (the default)
" I use `<C-y>` a fair bit to scroll the buffer and don't want the lag.
" `<C-\>` is an even better leader key!
let g:user_emmet_leader_key='<C-\>'

" and <C-\><C-\> is easier than <C-\>,
imap <C-\><C-\> <plug>(emmet-expand-abbr)
