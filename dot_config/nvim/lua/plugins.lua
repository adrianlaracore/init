local servers = require("_definitions")

vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/echasnovski/mini.comment",
	"https://github.com/echasnovski/mini.pairs",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/echasnovski/mini.statusline",
	"https://github.com/rmagatti/auto-session",
	"https://github.com/folke/snacks.nvim",
})

require("lazydev").setup()

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = servers.lsp,
	automatic_enable = true,
})

require("mason-tool-installer").setup({
	ensure_installed = servers.tools,
})

require("nvim-treesitter").install(servers.treesitter)

vim.api.nvim_create_autocmd("FileType", {
	pattern = servers.treesitter,
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("blink.cmp").setup({
	keymap = {
		["<C-space>"] = { "show", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-l>"] = { "accept", "fallback" },
		["<C-h>"] = { "cancel", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

require("conform").setup({
	formatters_by_ft = servers.formatters,
})

require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("auto-session").setup({ auto_restore_enabled = false })
require("snacks").setup({
	explorer = { enabled = true },
	notifier = { enabled = true },
	picker = { enabled = true, focus = "list" },
	quickfile = { enabled = true },
	scroll = { enabled = true },
	zoom = { enabled = true },
	lazygit = { enabled = true },
	gitbrowse = { enabled = true },
	statuscolumn = { enabled = true },
	layout = { enabled = true },
	terminal = { enabled = true, shell = "pwsh.exe" },
	input = { enabled = true },
})
