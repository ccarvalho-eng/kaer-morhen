local M = {}

function M.setup()
  local ok, alpha = pcall(require, 'alpha')
  if not ok then return end

  local ok_ascii, ascii = pcall(require, 'ascii')
  if not ok_ascii then return end

  local dashboard = require('alpha.themes.dashboard')

  -- Get random Neovim ASCII logo
  dashboard.section.header.val = ascii.get_random("text", "neovim")

  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
  }

  dashboard.section.footer.val = ""

  alpha.setup(dashboard.config)
end

return M
