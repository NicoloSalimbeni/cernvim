vim.api.nvim_set_keymap(
	"n",
	"<leader>fl",
	"<cmd>lua require('telescope.builtin').lsp_document_symbols({ symbols='function' })<cr>",
	{ noremap = true, silent = true, desc = "list of functions" }
)
