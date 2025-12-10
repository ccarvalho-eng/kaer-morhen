local M = {}

-- Generate diary template with current date
function M.generate_template()
  local date = os.date("%Y-%m-%d")

  local template = {
    "# " .. date,
    "",
    "## Morning Routine",
    "",
    "- [ ] Wake & Hydrate",
    "- [ ] Light Mobility / Stretching",
    "- [ ] Exercise",
    "- [ ] Shower",
    "- [ ] Meditation (10–15 min)",
    "- [ ] High-Quality Reading (10–20 min)",
    "- [ ] House Chores",
    "",
    "## Daily Planning",
    "",
    "- [ ] Review priorities (Top 1–3)",
    "- [ ] Process Inbox",
    "  - [ ] Email (Proton, Outlook, Gmail)",
    "  - [ ] Messages (Slack, Teams)",
    "  - [ ] Cycle & PR's (Linear, GitHub)",
    "- [ ] Define end-of-day success criteria",
    "",
    "## Meetings",
    "",
    "- [ ]",
    "",
    "## EOD",
    "",
    "- Done",
    "- Doing",
    "- Up Next",
    "- Blockers",
    "",
    "## Reflection",
    "",
    "- What went well?",
    "- What needs improvement?",
    "- Key takeaways for tomorrow",
    "",
    "## Notes",
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
