local map = require('config.keymaps').map

local function get_module_name(file_path)
  local path = file_path:gsub('%.ex$', ''):match('.*/lib/(.*)') or file_path:gsub('%.ex$', '')
  local parts = {}
  for part in path:gmatch('[^/]+') do
    local capitalized = part:gsub('_(%a)', string.upper):gsub('^%a', string.upper)
    table.insert(parts, capitalized)
  end
  return table.concat(parts, '.')
end

local function create_test_template(module_name)
  return string.format([[defmodule %sTest do
  use ExUnit.Case, async: true

  alias %s

  describe "" do
    test "" do
    end
  end
end
]], module_name, module_name)
end

local function toggle_test_file()
  local current_file = vim.fn.expand('%:p')
  local project_root = vim.fn.getcwd()
  local relative_path = current_file:gsub('^' .. vim.pesc(project_root) .. '/', '')
  local target_file

  if relative_path:match('_test%.exs$') then
    target_file = relative_path:gsub('/test/', '/lib/'):gsub('_test%.exs$', '.ex')
  elseif relative_path:match('%.ex$') then
    target_file = relative_path:gsub('/lib/', '/test/'):gsub('%.ex$', '_test.exs')
  else
    vim.notify('Not an Elixir implementation or test file', vim.log.levels.WARN)
    return
  end

  local full_path = project_root .. '/' .. target_file

  if vim.fn.filereadable(full_path) == 1 then
    vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
  else
    -- Create test file if it doesn't exist
    if target_file:match('_test%.exs$') then
      local dir = vim.fn.fnamemodify(full_path, ':h')
      vim.fn.mkdir(dir, 'p')

      local module_name = get_module_name(relative_path)
      local template = create_test_template(module_name)

      local file = io.open(full_path, 'w')
      if file then
        file:write(template)
        file:close()
        vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
        vim.notify('Created test file: ' .. target_file, vim.log.levels.INFO)
      end
    else
      vim.notify('File not found: ' .. target_file, vim.log.levels.WARN)
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'elixir',
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 98

    local opts = { buffer = 0, silent = true }

    -- Format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })

    -- Pipe operator shortcut
    map('i', '<C-l>', ' |> ', vim.tbl_extend('force', opts, { desc = 'Insert pipe operator' }))

    -- IEx terminal
    map('n', '<leader>i', function()
      vim.cmd('split | terminal iex -S mix')
      vim.cmd('wincmd p')
    end, vim.tbl_extend('force', opts, { desc = 'Open IEx terminal' }))

    -- Toggle between test and implementation
    map('n', '<leader>tt', toggle_test_file, vim.tbl_extend('force', opts, { desc = 'Toggle test/implementation' }))
  end,
})
