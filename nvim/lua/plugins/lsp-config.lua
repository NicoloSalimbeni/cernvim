return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd" },
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
				filetypes = { "python" },
			})
			lspconfig.cmake.setup({
				capabilities = capabilities,
				cmd = { "cmake-language-server" },
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP quick description" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
			--end configuration
		end,
	},
}
