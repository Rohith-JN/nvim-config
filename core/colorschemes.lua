--- This module will load a random colorscheme on nvim startup process.

local utils = require("utils")

local M = {}

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme2dir = {
  edge = "edge",
  nightfox = "nightfox.nvim",
}

M.edge = function()
  vim.g.edge_enable_italic = 1
  vim.g.edge_better_performance = 1

  vim.cmd([[colorscheme edge]])
end

M.nightfox = function()
  vim.cmd([[colorscheme duskfox]])
end

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme2dir))

  if not vim.tbl_contains(vim.tbl_keys(M), colorscheme) then
    local msg = "Invalid colorscheme: " .. colorscheme
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme, because all the colorschemes are declared as opt plugins, so the colorscheme isn't loaded yet.
  local status = utils.add_pack(M.colorscheme2dir[colorscheme])

  if not status then
    local msg = string.format("Colorscheme %s is not installed. Run PackerSync to install.", colorscheme)
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme and its settings
  M[colorscheme]()

  if vim.g.logging_level == "debug" then
    local msg = "Colorscheme: " .. colorscheme

    vim.notify(msg, vim.log.levels.DEBUG, { title = "nvim-config" })
  end
end

-- Load a random colorscheme
M.rand_colorscheme()
