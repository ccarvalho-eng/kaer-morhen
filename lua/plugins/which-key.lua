local M = {}

function M.setup()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  which_key.setup({
    preset = "classic",
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "rounded",
      padding = { 2, 2 },
    },
    layout = {
      spacing = 3,
    },
  })

  -- Register key groups
  which_key.add({
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>t", group = "Test" },
    { "<leader>w", group = "Wiki" },
    { "<leader>c", group = "Code" },
    { "<leader>b", group = "Buffer" },
  })
end

return M