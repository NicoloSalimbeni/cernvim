return {
  "lervag/vimtex",
  config = function()
    -- Use init for configuration, don't use the more common "config".
    vim.cmd([[let g:vimtex__general_view_method = 'okular']])
  end,
}
