return {
	"nvimtools/none-ls.nvim",
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {}) -- copied from docs for format on save
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,

				-- c++
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.diagnostics.cppcheck,

				-- cmake
				null_ls.builtins.diagnostics.cmake_lint,
				null_ls.builtins.formatting.cmake_format,

				-- bash
				null_ls.builtins.formatting.shfmt,

				-- python
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,
			},

			-- you can reuse a shared lspconfig on_attach callback here
			-- I copied this from the documentation for format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "format current file" })
	end,
}
