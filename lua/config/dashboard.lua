local api = vim.api
local keymap = vim.keymap
local dashboard = require("dashboard")

api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
  callback = function ()
    keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
    keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
  end
})

dashboard.setup({
  theme = 'doom',
  config = {
    header = {
      "                                                       ",
      "                                                       ",
      "                                                       ",
      "                                                       ",
      "                                                       ",
      " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
      " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
      " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
      " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
      " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
      " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
      "                                                       ",
      "                                                       ",
      "                                                       ",
      "                                                       ",
      "                                                       ",
      "                                                       ",
  },
    center = {
      {
        title = "Find  File                              ",
        desc = "Find  File                              ",
        action = "Telescope find_files",
        key = "<Leader> ff",
      },
      {
        title = "Recently opened files                   ",
        desc = "Recently opened files                   ",
        action = "Telescope oldfiles",
        key = "<Leader> fr"
      },
      {
        title = "Open Nvim config                        ",
        desc = "Open Nvim config                        ",
        action = "tabnew $MYVIMRC | tcd %:p:h",
        key = "<Leader> ev",
      },
      {
        title = "Quit Nvim                               ",
        desc = "Quit Nvim                               ",
        action = "qa",
        key = "q",
      },
    },
    footer = {}
  }
})