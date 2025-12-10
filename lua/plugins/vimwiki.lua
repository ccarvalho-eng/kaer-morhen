local M = {}

-- Open today's diary in a floating modal window
function M.open_diary_modal()
  local date = os.date("%Y-%m-%d")
  local wiki_path = vim.env.VIMWIKI_PATH or vim.fn.expand('~/vimwiki/')
  -- Remove trailing slash if present
  wiki_path = wiki_path:gsub("/$", "")
  local diary_path = wiki_path .. '/diary/' .. date .. '.md'

  -- Track all buffers opened during this modal session
  local session_buffers = {}

  -- Helper function to create/get wiki buffer
  local function get_or_create_wiki_buffer(path)
    local existing_buf = vim.fn.bufnr(path)
    local buf

    if existing_buf ~= -1 then
      -- Buffer already exists, use it
      buf = existing_buf
    else
      -- Create new scratch buffer and set it up
      buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_name(buf, path)
      vim.api.nvim_buf_set_option(buf, 'buftype', '')
      vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

      -- Load file content if it exists
      if vim.fn.filereadable(path) == 1 then
        local lines = vim.fn.readfile(path)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(buf, 'modified', false)
      end

      -- Track this buffer for cleanup
      table.insert(session_buffers, buf)
    end

    vim.api.nvim_buf_set_option(buf, 'filetype', 'vimwiki')

    -- Set up keymaps for this buffer
    local opts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set('n', 'q', '<cmd>q<cr>', opts)
    vim.keymap.set('n', '<Esc><Esc>', '<cmd>q<cr>', opts)

    return buf
  end

  -- Create the diary buffer
  local buf = get_or_create_wiki_buffer(diary_path)

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

  -- Auto-delete all session buffers when window is closed
  vim.api.nvim_create_autocmd('WinClosed', {
    pattern = tostring(win),
    callback = function()
      -- Delete all buffers created during this session
      for _, session_buf in ipairs(session_buffers) do
        if vim.api.nvim_buf_is_valid(session_buf) then
          vim.api.nvim_buf_delete(session_buf, { force = false })
        end
      end
    end,
    once = true,
  })

  -- Browse other wiki files with Telescope
  vim.keymap.set('n', '<C-p>', function()
    require('telescope.builtin').find_files({
      cwd = wiki_path,
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local selection = require('telescope.actions.state').get_selected_entry()
          require('telescope.actions').close(prompt_bufnr)

          -- Get or create buffer for selected file
          local selected_path = selection.path or selection[1]
          local new_buf = get_or_create_wiki_buffer(selected_path)

          -- Switch the floating window to the new buffer
          vim.api.nvim_win_set_buf(win, new_buf)
        end)
        return true
      end
    })
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