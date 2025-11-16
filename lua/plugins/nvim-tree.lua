local M = {}

function M.setup()
  require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      width = 30,
      number = true,
      relativenumber = true,
    },
    renderer = {
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = false,
    },
  })
end

return M
