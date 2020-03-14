"               _                           
"    ___  _ __ (_)  ___   ___   _ __   _ __ 
"   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
"  |  __/| |   | || (__ | (_) || | | || |   
"   \___||_|   |_| \___| \___/ |_| |_||_|   
"                                           

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

" Tab width
set tabstop=3
set shiftwidth=3

" Show relative line numbers
set number rnu

" Pretty color scheme that works well with the one chosen for alacritty
colorscheme slate

" Settings for neovide
set guifont=IBMPlex\ Mono:h16
let g:neovide_cursor_vfx_mode = "sonicboom"


" FUNCTIONS

" Sets up the editor for spaces instead of tabs - WIP
" https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
fu! SpaceTabs()
	:set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
endfunction
