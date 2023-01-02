require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "lua", "vim", "javascript", "typescript", "scss", "html", "dart", "css" },
  auto_install = true,
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'help' }, -- list of language that will be disabled
  },
}
