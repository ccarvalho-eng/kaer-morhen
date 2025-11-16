local M = {}

function M.setup()
  local ok, alpha = pcall(require, 'alpha')
  if not ok then return end

  local dashboard = require('alpha.themes.dashboard')

  -- Witcher logo
  dashboard.section.header.val = {
    [[⠀⠀⠀⠀⠀⢀⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢢⡀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⢾⢿⣄⡀⠀⠀⠀⠀⠀⠱⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠎⠀⠀⠀⠀⠀⢀⣠⡿⡷⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠈⡳⣿⣻⣿⣶⣤⣄⡀⠀⠘⣿⣷⡼⣦⡹⣿⣿⣿⣿⣿⣿⢏⣴⢇⣾⣿⠃⠀⢀⣠⣤⣶⣿⣟⣿⢞⠁⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⢳⡠⡙⠷⣯⣻⢿⣿⣿⣶⢌⣩⣭⣭⣥⣽⣿⣿⣿⣿⣯⣮⣭⣭⣍⡡⣶⣿⣿⡿⣟⣽⠾⢋⠄⡞⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠈⢧⢻⣶⡝⠻⣿⣿⡿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⢿⣿⣿⠟⢫⣶⡟⡼⠁⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠈⢧⡛⣿⣶⡄⠙⢵⣷⣯⣻⢿⣷⣿⢿⣿⢸⡇⣿⡿⣿⣾⡿⣟⣽⣾⡮⠋⢠⣶⣿⢏⡼⠁⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠐⠒⠺⠿⢿⣦⠀⠙⢌⠛⢇⣴⣷⡌⠙⣻⢽⣾⣟⡏⣿⣿⣿⣿⢹⣻⣷⡯⣿⠏⢡⣾⣦⡸⠛⡡⠋⠀⣰⡿⠿⠗⠒⠂⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⣁⣠⣴⣜⡿⣿⣿⡼⣄⡉⠉⠈⠙⡿⣿⡟⢿⣿⢿⠋⠁⠉⢉⣠⢯⣿⣿⢿⣣⣦⣄⣈⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⣀⣠⣴⣶⣿⣿⣿⣿⣿⣿⣷⣯⣻⢿⣭⣿⣼⣿⢽⣿⣧⣼⣿⡯⣷⣧⣿⣭⡷⣟⣽⣾⣿⣿⣿⣿⣿⣿⣶⣦⣄⣀⠀⠀⠀]],
    [[⠐⠚⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠚⠙⢿⡻⢯⣿⣿⣿⣿⡽⢟⡿⠋⠓⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠓⠂]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣶⣶⣶⣶⡦⠀⣯⣖⠈⠉⠉⠁⣲⣽⠀⢴⣶⣶⣶⣶⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⣰⣾⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⢛⡿⠿⠿⠿⠿⢿⡟⠀⠀⠉⠻⢿⣿⣿⣿⣿⣿⣷⣆⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⢸⡟⡶⡤⢤⢼⢻⡇⠀⠀⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⠟⠋⠀⠀⠀⠀⣠⣴⡖⠀⠸⠀⠃⠀⠀⠘⠀⠇⠀⢲⣦⣄⠀⠀⠀⠀⠉⠻⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⣰⣿⣿⠟⠋⠀⠀⠀⠀⢀⣤⣾⣿⠏⠀⠀⢡⠀⡀⠀⠀⢀⠀⡌⠀⠀⠹⣿⣷⣤⡀⠀⠀⠀⠀⠙⠻⣿⣿⣆⠀⠀⠀⠀]],
    [[⠀⠀⢀⣼⡿⠏⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠏⠀⠀⠀⢸⡇⣿⣦⣴⣿⢸⡇⠀⠀⠀⠸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠹⢿⣧⡀⠀⠀]],
    [[⠀⢀⠜⠉⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠋⠀⠀⠀⠀⢸⡇⣿⣿⣿⣿⢸⡇⠀⠀⠀⠀⠙⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠉⠣⡀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡿⠃⠀⠀⠀⠀⠀⠸⠀⠙⠿⠿⠊⠀⠇⠀⠀⠀⠀⠀⠘⢿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠁⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠈⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡘⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡣⠤⠤⢜⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢛⣤⣤⣤⣤⡓⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠛⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  }

  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
  }

  dashboard.section.footer.val = ""

  dashboard.config.layout = {
    { type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
  }

  alpha.setup(dashboard.config)
end

return M
