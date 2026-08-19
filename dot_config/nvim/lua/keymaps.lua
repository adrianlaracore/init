local fn = require("_functions")
local opts = { noremap = true, silent = true, }

-- CORE
vim.keymap.set("n", "<a-=>", "<cmd>vsplit<cr>", opts)
vim.keymap.set("n", "<a-->", "<cmd>split<cr>", opts)
vim.keymap.set("n", "<a-q>", "<cmd>q<cr>", opts)
vim.keymap.set("n", "<a-h>", "<c-w>h", opts)
vim.keymap.set("n", "<a-j>", "<c-w>j", opts)
vim.keymap.set("n", "<a-k>", "<c-w>k", opts)
vim.keymap.set("n", "<a-l>", "<c-w>l", opts)
vim.keymap.set("n", "<a-b><c-h>", "<cmd>bfirst<cr>", opts)
vim.keymap.set("n", "<a-b><a-j>", "<cmd>bprevious<cr>", opts)
vim.keymap.set("n", "<a-b><a-k>", "<cmd>bnext<cr>", opts)
vim.keymap.set("n", "<a-b><a-l>", "<cmd>blast<cr>", opts)
vim.keymap.set("n", "<a-b><a-q>", "<cmd>lua Snacks.bufdelete()<cr>", opts)
vim.keymap.set("n", "<a-b><a-a>", "<cmd>lua Snacks.bufdelete.all()<cr>", opts)
vim.keymap.set("n", "<a-b><a-o>", "<cmd>lua Snacks.bufdelete.other()<cr>", opts)
vim.keymap.set("n", "<a-t><a-n>", "<cmd>tabnew<cr>", opts)
vim.keymap.set("n", "<a-t><a-t>", "<cmd>tab split<cr>", opts)
vim.keymap.set("n", "<a-t><a-h>", "<cmd>tabfirst<cr>", opts)
vim.keymap.set("n", "<a-t><a-j>", "<cmd>tabprevious<cr>", opts)
vim.keymap.set("n", "<a-t><a-k>", "<cmd>tabnext<cr>", opts)
vim.keymap.set("n", "<a-t><a-l>", "<cmd>tablast<cr>", opts)
vim.keymap.set("n", "<a-t><a-q>", "<cmd>tabclose<cr>", opts)
vim.keymap.set("n", "<a-e>e", "<cmd>qa!<cr>", opts)

-- SNACKS FINDERS
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.files(fn.explorer_files) end, opts)
vim.keymap.set("n", "<leader>,", function() Snacks.picker.grep({ focus = 'input' }) end, opts)
vim.keymap.set("n", "<leader>.", function() Snacks.picker.grep_buffers({ focus = 'input' }) end, opts)
vim.keymap.set("n", "<leader><tab>", function() Snacks.picker.explorer(fn.explorer_quick) end, opts)
vim.keymap.set("n", "<tab>", function() Snacks.picker.buffers({ layout = { preset = "vscode", preview = false } }) end, opts)
vim.keymap.set("n", "<s-tab>", function() Snacks.explorer() end, opts)

-- SNACKS CONFIG
vim.keymap.set("n", "<leader>oc", function() Snacks.picker.colorschemes({ layout = { preset = "select", preview = true } }) end, opts)
vim.keymap.set("n", "<leader>od", function() Snacks.picker.diagnostics() end, opts)
vim.keymap.set("n", "<leader>ok", function() Snacks.picker.keymaps() end, opts)

-- SNACKS GIT
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, opts)
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, opts)
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, opts)
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_files() end, opts)
vim.keymap.set("n", "<leader>gG", function() Snacks.picker.git_grep() end, opts)
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, opts)
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_stash() end, opts)
vim.keymap.set("n", "<leader>go", function() Snacks.gitbrowse() end, opts)

-- LSP
vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
vim.keymap.set("n", "gf", function() require("conform").format({ async = true }) end, opts)
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, opts)
vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)
vim.keymap.set("n", "gs", function() Snacks.picker.lsp_symbols() end, opts)
vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

-- TERMINAL
vim.keymap.set({ "n", "t" }, "<leader>tt", fn.terminal_toggle, opts)
vim.keymap.set({ "n", "t" }, "<leader>tn", fn.terminal_create, opts)
vim.keymap.set({ "n", "t" }, "<leader>tm", fn.terminal_toggle_modal, opts)
vim.keymap.set("t", "<leader>tb", "<c-\\><c-n>", opts)

-- MISC
vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
vim.keymap.set("n", "<leader>sr", "<cmd>AutoSession restore<cr>", opts)

-- SNACKS TOGGLES
Snacks.toggle.zoom():map("<s-z>")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<s-w>")
Snacks.toggle.diagnostics():map("<s-d>")
Snacks.toggle.line_number():map("<s-n>")
Snacks.toggle.option("relativenumber"):map("<s-r>")
Snacks.toggle.option("background", { off = "dark", on = "light" }):map("<s-b>")
Snacks.toggle.indent():map("<s-i>")
Snacks.toggle.dim():map("<s-m>")
