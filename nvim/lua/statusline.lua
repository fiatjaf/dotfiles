local api = vim.api
local opt = vim.opt

local function err_count(severity)
  local diags = vim.diagnostic.get(api.nvim_get_current_buf(), { severity = severity })
  if not next(diags) then
    return ""
  else
    return " " .. #diags .. " "
  end
end

local function get_modified()
  local well_are_are = opt.modified:get()
  if well_are_are then
    return "  "
  else
    return ""
  end
end

-- Yanked right from galaxyline because I like this little thing
local function scrollbar()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local default_chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local chars = default_chars
  local index = 1

  if current_line == 1 then
    index = 1
  elseif current_line == total_lines then
    index = #chars
  else
    local line_no_fraction = vim.fn.floor(current_line) / vim.fn.floor(total_lines)
    index = vim.fn.float2nr(line_no_fraction * #chars)
    if index == 0 then
      index = 1
    end
  end
  return chars[index]
end

local function metals_status()
  return vim.g["metals_status"] or ""
end

local function readonly()
  if opt.readonly:get() then
    return "  "
  else
    return ""
  end
end

local function super_custom_status_line()
  return table.concat({
    "%#StatusBackground#",
    "%f",
    readonly(),
    get_modified(),
    "%#StatusError#",
    err_count("Error"),
    "%#StatusWarn#",
    err_count("Warn"),
    "%#StatusLine#",
    "%#" .. metals_status() .. "#",
    "%=", -- Left and Right divider
    "%l, ", -- line number
    "%c ", -- column number
    scrollbar(),
    "%"
  })
end

local function super_custom_winbar()
  return table.concat({
    "%=", -- divider
    "%#StatusLine#", -- get the colors right
    "%m ",
    "%t", -- filename only
  })
end

return {
  super_custom_status_line = super_custom_status_line,
  super_custom_winbar = super_custom_winbar,
}
