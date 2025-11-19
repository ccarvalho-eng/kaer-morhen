local M = {}

function M.setup()
  -- Get wiki path from environment variable or use default
  local wiki_path = vim.env.VIMWIKI_PATH or '~/vimwiki/'

  -- Set vimwiki list before plugin loads
  vim.g.vimwiki_list = {
    {
      path = wiki_path,
      syntax = 'markdown',
      ext = '.md',
    }
  }

  -- Use markdown syntax highlighting
  vim.g.vimwiki_ext2syntax = {
    ['.md'] = 'markdown',
    ['.markdown'] = 'markdown',
    ['.mdown'] = 'markdown',
  }

  -- Don't treat all markdown files as vimwiki
  vim.g.vimwiki_global_ext = 0

  -- Disable table mappings (can be enabled if needed)
  vim.g.vimwiki_table_mappings = 0
end

function M.keymaps()
  local opts = { noremap = true, silent = true }

  -- Wiki navigation
  vim.keymap.set('n', '<leader>ww', '<Plug>VimwikiIndex', opts)
  vim.keymap.set('n', '<leader>wt', '<Plug>VimwikiTabIndex', opts)
  vim.keymap.set('n', '<leader>ws', '<Plug>VimwikiUISelect', opts)

  -- Diary
  vim.keymap.set('n', '<leader>wi', '<Plug>VimwikiDiaryIndex', opts)
  vim.keymap.set('n', '<leader>w<leader>w', '<Plug>VimwikiMakeDiaryNote', opts)
  vim.keymap.set('n', '<leader>w<leader>t', '<Plug>VimwikiTabMakeDiaryNote', opts)
  vim.keymap.set('n', '<leader>w<leader>y', '<Plug>VimwikiMakeYesterdayDiaryNote', opts)
  vim.keymap.set('n', '<leader>w<leader>m', '<Plug>VimwikiMakeTomorrowDiaryNote', opts)
end

return M