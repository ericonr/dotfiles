" ericonr's nvim config


" BEHAVIOR

" Case insensitive searches, unless the term has a capital letter
set ignorecase
set smartcase


" SHORTCUTS

" Shortcuts for quickly going back to normal mode
:imap jk <Esc>
:imap kj <Esc>

" Shortcuts for pasting and yanking from the system clipboard
:nmap wp "+p
:vmap wy "+y

" Shortcuts for working with tabs
:nmap tr :tabr<cr>
:nmap tl :tabl<cr>
:nmap tp :tabp<cr>
:nmap tn :tabn<cr>


" APPEARANCE

" Show relative line numbers
set number rnu

" Pretty color scheme that works well with the one chosen for alacritty
colorscheme slate

