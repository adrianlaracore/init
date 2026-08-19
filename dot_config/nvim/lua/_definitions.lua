local M = {}

M.treesitter = {
	"lua",
	"vim",
	"vimdoc",
	"query",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"scss",
	"json",
	"yaml",
	"markdown",
	"markdown_inline",
}

M.lsp = {
	"lua_ls",
	"ts_ls",
	"angularls",
	"html",
	"cssls",
	"tailwindcss",
	"emmet_ls",
	"jsonls",
}

M.tools = {
	"stylua",
	"biome",
	"prettierd",
	"prettier",
	"eslint_d",
}

M.formatters = {
	lua = { "stylua" },
	javascript = { "biome", "prettierd", "prettier", "eslint_d", stop_after_first = true },
	typescript = { "biome", "prettierd", "prettier", "eslint_d", stop_after_first = true },
	css = { "biome", "prettierd", "prettier", stop_after_first = true },
	scss = { "biome", "prettierd", "prettier", stop_after_first = true },
	html = { "prettierd", "prettier", stop_after_first = true },
	json = { "prettierd", "prettier", stop_after_first = true },
	yaml = { "prettierd", "prettier", stop_after_first = true },
	markdown = { "prettierd", "prettier", stop_after_first = true },
}

return M
