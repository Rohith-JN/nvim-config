require("toggleterm").setup{
  size = 80,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shading_factor = 2,
  shade_terminals = true,
  start_in_insert = true,
  persist_size = true,
  shade_filetypes = {},
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved',
    winblend = 0,
  },
}

