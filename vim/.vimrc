" ── Visual ──────────────────────────────────────
syntax on
colorscheme habamax
set cursorline
set showmatch
set hlsearch
set incsearch
set laststatus=2
set ruler
set wildmenu
set scrolloff=5

" ── General ──────────────────────────────────────
set nu
set mouse=a

" ── Markdown Preview (markdown-preview.nvim) ─────
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_echo_preview_url = 1
let g:mkdp_theme = 'dark'
let g:mkdp_preview_options = {
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle',
      \ 'hide_yaml_meta': 1,
      \ 'content_editable': v:false,
      \ 'disable_filename': 0,
      \ 'toc': {}
      \ }

autocmd FileType markdown nnoremap <buffer> <leader>p <Plug>MarkdownPreviewToggle
autocmd FileType markdown nnoremap <buffer> <leader>P <Plug>MarkdownPreviewStop
