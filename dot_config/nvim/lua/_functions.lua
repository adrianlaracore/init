local M = {}

M.explorer_files = { focus = 'input', preview = false, layout = { preset = 'vscode' }, }

M.explorer_quick = {
  title = 'Quick Explorer',
  replace_netrw = false,
  layout = { preset = 'vscode' },
  formatters = {
    file = { git_status_hl = false, },
  },
  diagnostics = false,
  git_status = false,
  auto_close = true,
}

local terminals = {}
local terminals_visible = false
local modal_terminal = nil

function M.terminal_create()
  local term = Snacks.terminal.open()
  table.insert(terminals, term)
  terminals_visible = true
  return term
end

local function hide_all_terminals()
  for _, term in ipairs(terminals) do
    if term:buf_valid() then term:hide() end
  end
  terminals_visible = false
end

local function show_all_terminals()
  local has_valid = false
  for _, term in ipairs(terminals) do
    if term:buf_valid() then
      term:show()
      has_valid = true
    end
  end
  if not has_valid then M.terminal_create() end
  terminals_visible = true
end

function M.terminal_toggle()
  if #terminals == 0 then
    M.terminal_create()
    return
  end
  if terminals_visible then hide_all_terminals() else show_all_terminals() end
end

function M.terminal_toggle_modal()
  if modal_terminal and modal_terminal:buf_valid() then
    if modal_terminal:win_valid() then
      modal_terminal:hide()
    else
      modal_terminal:show()
    end
  else
    modal_terminal = Snacks.terminal.open(nil, { win = { position = "float" } })
  end
end

return M
