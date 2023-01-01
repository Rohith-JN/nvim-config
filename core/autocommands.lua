local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup("dynamic_smartcase", {})
autocmd({ "CmdLineEnter" }, {
    group = "dynamic_smartcase",
    pattern = ":",
    command = "set nosmartcase"
})
autocmd({ "CmdLineLeave" }, {
    group = "dynamic_smartcase",
    pattern = ":",
    command = "set smartcase"
})

vim.api.nvim_create_augroup("term_settings", {})
autocmd({ "TermOpen" }, {
    group = "term_settings",
    pattern = "*",
    command = "setlocal norelativenumber nonumber"
})
autocmd({ "TermOpen" }, {
  group = "term_settings",
  pattern = "*",
  command = "startinsert"
})

vim.api.nvim_create_augroup("resume_cursor_position", {})
autocmd({ "BufReadPost" }, {
    group = "resume_cursor_position",
    pattern = "*",
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

vim.api.nvim_create_augroup("custom_highlight", {})
autocmd({ "Colorscheme" }, {
    group = "custom_highlight",
    pattern = "*",
    callback = function()
        vim.api.nvim_exec('highlight Cursor cterm=bold gui=bold guibg=#00c918 guifg=black', false)
        vim.api.nvim_exec('highlight Cursor cterm=bold gui=bold guibg=#00c918 guifg=black', false)
        vim.api.nvim_exec('highlight Cursor2 guifg=red guibg=red', false)
        vim.api.nvim_exec('highlight FloatBorder guifg=LightGreen guibg=NONE', false)
        vim.api.nvim_exec('highlight MatchParen cterm=bold,underline gui=bold,underline', false)
    end,
})

local fn = vim.fn
local api = vim.api
local utils = require("utils")

api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "*",
  group = api.nvim_create_augroup("non_utf8_file", { clear = true }),
  callback = function()
    if vim.bo.fileencoding ~= "utf-8" then
      vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
    end
  end,
})

api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "YankColor", timeout = 300 }
  end,
})

api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = fn.fnamemodify(ctx.file, ":p:h")
    utils.may_create_dir(dir)
  end,
})

api.nvim_create_augroup("auto_read", { clear = true })

api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
  end,
})

api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    if fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

api.nvim_create_autocmd("VimResized", {
  group = api.nvim_create_augroup("win_autoresize", { clear = true }),
  desc = "autoresize windows on resizing operation",
  command = "wincmd =",
})
