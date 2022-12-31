local api = vim.api
local utils = require("utils")
local expected_ver = "0.8.1"
local nvim_ver = utils.get_nvim_version()

if nvim_ver ~= expected_ver then
  local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, nvim_ver)
  api.nvim_err_writeln(msg)
  return
end

local core_conf_files = {
  "globals.lua", 
  "options.lua", 
  "autocommands.lua", 
  "mappings.lua", 
  "plugins.vim", 
  "colorschemes.lua", 
}

for _, name in ipairs(core_conf_files) do
  local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
