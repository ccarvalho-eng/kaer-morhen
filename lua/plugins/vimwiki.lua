local M = {}

-- Open today's diary in a floating modal window
function M.open_diary_modal()
  local date = os.date("%Y-%m-%d")
  local wiki_path = vim.env.VIMWIKI_PATH or vim.fn.expand('~/vimwiki/')
  -- Remove trailing slash if present
  wiki_path = wiki_path:gsub("/$", "")
  local diary_path = wiki_path .. '/diary/' .. date .. '.md'

  -- Create or open the diary file in a buffer
  local temp_buf = vim.api.nvim_create_buf(false, false)
  local buf
  vim.api.nvim_buf_call(temp_buf, function()
    vim.cmd('edit ' .. vim.fn.fnameescape(diary_path))
    buf = vim.api.nvim_get_current_buf()
  end)

  -- Delete the temporary buffer if it's different from the loaded one
  if temp_buf ~= buf then
    vim.api.nvim_buf_delete(temp_buf, { force = true })
  end

  -- Calculate window dimensions (80% of screen)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'rounded',
  })

  -- Set window options
  vim.api.nvim_win_set_option(win, 'winblend', 0)
  vim.api.nvim_win_set_option(win, 'cursorline', true)
  vim.api.nvim_win_set_option(win, 'number', true)
  vim.api.nvim_win_set_option(win, 'relativenumber', true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'filetype', 'vimwiki')

  -- Close modal with q or <Esc><Esc>
  local opts = { noremap = true, silent = true, buffer = buf }
  vim.keymap.set('n', 'q', '<cmd>q<cr>', opts)
  vim.keymap.set('n', '<Esc><Esc>', '<cmd>q<cr>', opts)

  -- Browse other wiki files with Telescope
  vim.keymap.set('n', '<C-p>', function()
    require('telescope.builtin').find_files({ cwd = wiki_path })
  end, { noremap = true, silent = true, buffer = buf, desc = 'Find wiki files' })
end

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

  -- Diary modal
  vim.keymap.set('n', '<leader>wd', function() M.open_diary_modal() end,
    { noremap = true, silent = true, desc = "Open today's diary in modal" })
end

return M