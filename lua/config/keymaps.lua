local M = {}

-- Reusable keymap helper
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Core keymaps
M.map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- File explorer
M.map('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file tree and reveal current file' })

return M
