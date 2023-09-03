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

" Shortcuts for paragraph nagivation
:nmap j gj
:nmap k gk

" Shortcuts for quickly going back to normal mode
:imap jk <Esc>
:imap kj <Esc>

" Shortcuts for pasting and yanking from the system clipboard
:nmap mp "+p
:vmap wy "+y

" Shortcuts for working with tabs
:nmap tr :tabr<cr>
:nmap tl :tabl<cr>
:nmap tp :tabp<cr>
:nmap tn :tabn<cr>
:nmap TN :tabnew<cr>

" Shortcuts for fzf
:nmap <space><space> :FZF<cr>
:nmap <space>f :FZF!<cr>
:nmap <space>n :call fzf#run({'sink': 'tabedit'})<cr>
:nmap <space>g :call fzf#run({'source': 'git ls-files', 'sink': 'e', 'options': '--tac'})<cr>


" APPEARANCE

" Tab width
set tabstop=3
set shiftwidth=3

" Show relative line numbers
set number rnu

" Pretty color scheme
colorscheme peachpuff

" Settings for Void stuff
autocmd BufNewFile,BufRead template setfiletype sh

" Rainbow Parentheses
let g:rainbow_active = 1
let g:rainbow_conf = { 'ctermfgs': ['darkblue', 'darkred', 'darkgreen', 'darkmagenta', 'darkcyan'] }


" TELESCOPE

" Set up fzf for telescope (requires running make in the fzf directory)
lua << EOF
require('telescope').load_extension('fzf')
EOF


" TREE-SITTER

" Use tree-sitter to highlight Latex, it's considerably less laggy
fu! LatexUseTS()
	:syntax clear
	:TSEnable highlight
	:TSBufEnable highlight
endfunction
autocmd BufNewFile,BufRead *.tex :call LatexUseTS()


" LANGUAGE SERVER

" Partly from https://github.com/neovim/nvim-lspconfig/blob/master/README.md
lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- rust_analyzer
local servers = { "clangd" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

if (false)
then
	nvim_lsp.ccls.setup {
		 init_options = {
			compilationDatabaseDirectory = "build";
		 };
		 on_attach = on_attach;
	}
end
EOF


" FUNCTIONS

" Sets up the editor for spaces instead of tabs - WIP
" https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
fu! SpaceTabs()
	:set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
endfunction
