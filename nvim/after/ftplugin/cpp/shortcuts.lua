-- telescope to search functions and methods: https://neovim.discourse.group/t/telescope-lsp-lsp-document-symbols-how-to-show-only-functions/2971/2
vim.api.nvim_set_keymap(
	"n",
	"<leader>fl",
	"<cmd>lua require('telescope.builtin').lsp_document_symbols({ symbols={'function', 'method'}})<cr>",
	{ noremap = true, silent = true, desc = "list of functions" }
)
