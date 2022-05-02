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

local function status_filename()
  local abs = vim.fn.expand("%F")
  local home = vim.fn.expand("~")
  local cwd = vim.fn.getcwd()

  if abs:find("term://") == 1 then
    return abs
  end

  local s, e = abs:find(cwd)
  if s == 1 then
    local suffix = abs:sub(e)
    if suffix:sub(1, 2) == './' then
      suffix = suffix:sub(2)
    end
    if suffix:sub(1, 1) == '/' then
      suffix = suffix:sub(1)
    end
    return "> ./" .. suffix
  end

  local s, e = abs:find(home)
  if s == 1 then
    return "~" .. abs:sub(e + 1)
  end

  if abs:sub(0, 1) == "/" then
    return "!" .. abs
  end

  if abs:sub(1, 2) == './' then
    abs = abs:sub(2)
  end
  return "> ./" .. abs
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

-- TODO is there a way to do this without making it global?
function Super_custom_status_line()
  return table.concat({
    "%#StatusBackground#",
    status_filename(),
    readonly(),
    get_modified(),
    "%#StatusError#",
    err_count("Error"),
    "%#StatusWarn#",
    err_count("Warn"),
    "%#StatusLine#",
    metals_status(),
    "%=", -- Left and Right divider
    "%l, ", -- line number
    "%c ", -- column number
    scrollbar(),
    "%"
  })
end
