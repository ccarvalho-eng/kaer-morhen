local M = {}

-- Generate diary template with current date
function M.generate_template()
  local date = os.date("%Y-%m-%d")

  local template = {
    "# " .. date,
    "",
    "## Dawn Rituals",
    "",
    "- [ ] Rouse thyself as first light breaketh o’er the far hills",
    "- [ ] Take a draught of cool dawn-water to hearten flesh and spirit",
    "- [ ] Walk the old war-forms handed down from shield-kin",
    "- [ ] Cast off night’s murk with a brief cleansing rite",
    "- [ ] Still the breath, and let the mind wander not",
    "- [ ] Turn thy gaze to elder scrolls, runes, and lore of bygone days",
    "- [ ] Set hearth, hall, and humble tools in rightful order",
    "",
    "## Quest Planning",
    "",
    "- [ ] Reckon thy foremost charges and sworn undertakings (Top 3)",
    "- [ ] Sort the day’s missives and tidings",
    "  - [ ] Scribed letters (Proton, Outlook, Gmail)",
    "  - [ ] Raven-borne words (Slack, Teams)",
    "  - [ ] Guild-kept task annals (Linear, GitHub)",
    "- [ ] Name the deeds thou seekest ere sunfall",
    "",
    "## Council Gatherings",
    "",
    "- [ ]",
    "",
    "## Dusk Report",
    "",
    "- Works wrought beneath the wandering sun",
    "- Labors yet unended upon the day’s long road",
    "- Hunts awaiting on the morrow’s breath",
    "- Trials, hexes, and ill winds met along the path",
    "",
    "## Evening Reflection",
    "",
    "- Strengths shown in toil and striving",
    "- Falterings laid bare in twilight’s quiet",
    "- Wisdom to bear into the newborn dawn",
    "",
    "## Scribe's Notes",
    "",
    "- ",
    "",
  }

  return template
end

-- Apply template to current buffer if it's empty
function M.apply_template()
  -- Only apply if buffer is empty or only has whitespace
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local is_empty = true

  for _, line in ipairs(lines) do
    if line:match("%S") then
      is_empty = false
      break
    end
  end

  if is_empty then
    local template = M.generate_template()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
    -- Move cursor to the first task checkbox
    vim.api.nvim_win_set_cursor(0, {5, 6})
  end
end

-- Setup autocommand for diary files
function M.setup()
  local wiki_path = vim.env.VIMWIKI_PATH or vim.fn.expand('~/vimwiki/')
  -- Remove trailing slash if present
  wiki_path = wiki_path:gsub("/$", "")
  local diary_pattern = wiki_path .. '/diary/*.md'

  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = diary_pattern,
    callback = function()
      M.apply_template()
    end,
    desc = "Apply vimwiki diary template to new diary entries"
  })
end

return M
