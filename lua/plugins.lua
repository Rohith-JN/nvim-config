local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

--- Install packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
	-- Where to install packer.nvim -- the package manager (we make it opt)
	local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

	if fn.glob(packer_dir) ~= "" then
		return false
	end

	-- Auto-install packer in case it hasn't been installed.
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

	local packer_repo = "https://github.com/wbthomason/packer.nvim"
	local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
	vim.cmd(install_cmd)

	return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")

packer.startup({
	function(use)
		-- it is recommended to put impatient.nvim before any other plugins
		use({ "lewis6991/impatient.nvim", config = [[require('impatient')]] })

		use({ "wbthomason/packer.nvim", opt = true })

		use({ "onsails/lspkind-nvim", event = "VimEnter" })
		-- auto-completion engine
		use({ "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] })

		-- nvim-cmp completion sources
		use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })

		-- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
		use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })

		-- Python indent (follows the PEP8 style)
		use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

		-- Python-related text object
		use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })

		use({ "machakann/vim-swap", event = "VimEnter" })

		-- IDE for Lisp
		if utils.executable("sbcl") then
			-- use 'kovisoft/slimv'
			use({ "vlime/vlime", rtp = "vim/", ft = { "lisp" } })
		end

		-- Super fast buffer jump
		use({
			"phaazon/hop.nvim",
			event = "VimEnter",
			config = function()
				vim.defer_fn(function()
					require("config.nvim_hop")
				end, 2000)
			end,
		})

		-- Show match number and index for searching
		use({
			"kevinhwang91/nvim-hlslens",
			branch = "main",
			keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
			config = [[require('config.hlslens')]],
		})

		use({ "EdenEast/nightfox.nvim", opt = true })

		use({ "kyazdani42/nvim-web-devicons", event = "VimEnter" })

		use({
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			cond = firenvim_not_active,
			config = [[require('config.statusline')]],
		})

		-- toggleterm
		use({ "akinsho/toggleterm.nvim", config = [[require('config.toggle-term')]] })

		use({
			"akinsho/bufferline.nvim",
			event = "VimEnter",
			cond = firenvim_not_active,
			config = [[require('config.bufferline')]],
		})

		-- fancy start screen
		use({
			"glepnir/dashboard-nvim",
			event = "VimEnter",
			cond = firenvim_not_active,
			config = [[require('config.dashboard-nvim')]],
		})

		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			config = [[require('config.telescope')]],
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		-- lsp code formatting
		use({ "jose-elias-alvarez/null-ls.nvim", config = [[require('config.null-ls')]] })

		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "VimEnter",
			config = [[require('config.indent-blankline')]],
		})

		-- Highlight URLs inside vim
		use({ "itchyny/vim-highlighturl", event = "VimEnter" })

		-- notification plugin
		use({
			"rcarriga/nvim-notify",
			event = "BufEnter",
			config = function()
				vim.defer_fn(function()
					require("config.nvim-notify")
				end, 2000)
			end,
		})

		-- Automatic insertion and deletion of a pair of characters
		use({ "Raimondi/delimitMate", event = "InsertEnter" })

		-- Comment plugin
		use({ "tpope/vim-commentary", event = "VimEnter" })

		-- better UI for some nvim actions
		use({ "stevearc/dressing.nvim" })

		-- Manage your yank history
		use({
			"gbprod/yanky.nvim",
			config = [[require('config.yanky')]],
		})

		-- Repeat vim motions
		use({ "tpope/vim-repeat", event = "VimEnter" })

		use({ "nvim-zh/better-escape.vim", event = { "InsertEnter" } })

		use({ "Neur1n/neuims", event = { "InsertEnter" } })

		use({ "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = { "Conflicted" } })

		use({
			"ruifm/gitlinker.nvim",
			requires = "nvim-lua/plenary.nvim",
			event = "User InGitRepo",
			config = [[require('config.git-linker')]],
		})

		use({ "kevinhwang91/nvim-bqf", ft = "qf", config = [[require('config.bqf')]] })

		-- Another markdown plugin
		use({ "preservim/vim-markdown", ft = { "markdown" } })

		use({ "folke/zen-mode.nvim", cmd = "ZenMode", config = [[require('config.zen-mode')]] })

		use({ "chrisbra/unicode.vim", event = "VimEnter" })

		-- Additional powerful text object for vim, this plugin should be studied
		-- carefully to use its full power
		use({ "wellle/targets.vim", event = "VimEnter" })

		-- Plugin to manipulate character pairs quickly
		use({ "machakann/vim-sandwich", event = "VimEnter" })

		-- Add indent object for vim (useful for languages like Python)
		use({ "michaeljsmith/vim-indent-object", event = "VimEnter" })

		-- Modern matchit implementation
		use({ "andymass/vim-matchup", event = "VimEnter" })

		use({ "tpope/vim-scriptease", cmd = { "Scriptnames", "Message", "Verbose" } })

		-- Debugger plugin
		use({ "sakhnik/nvim-gdb", run = { "bash install.sh" }, opt = true, setup = [[vim.cmd('packadd nvim-gdb')]] })

		-- Session management plugin
		use({ "tpope/vim-obsession", cmd = "Obsession" })

		-- nvim-treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			event = "BufEnter",
			run = ":TSUpdate",
			config = [[require('config.treesitter')]],
		})
		-- The missing auto-completion for cmdline!
		use({ "gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]] })

		-- file explorer
		use({
			"kyazdani42/nvim-tree.lua",
			config = [[require('config.nvim-tree')]],
		})

		use({ "j-hui/fidget.nvim", after = "nvim-lspconfig", config = [[require('config.fidget-nvim')]] })
	end,
	config = {
		max_jobs = 16,
		compile_path = packer_util.join_paths(fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
	},
})

-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
	-- We run packer.sync() here, because only after packer.startup, can we know which plugins to install.
	-- So plugin installation should be done after the startup process.
	packer.sync()
else
	local status, _ = pcall(require, "packer_compiled")
	if not status then
		local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
		vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
	end
end

-- Auto-generate packer_compiled.lua file
api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*/nvim/lua/plugins.lua",
	group = api.nvim_create_augroup("packer_auto_compile", { clear = true }),
	callback = function(ctx)
		local cmd = "source " .. ctx.file
		vim.cmd(cmd)
		vim.cmd("PackerCompile")
		vim.notify("PackerCompile done!", vim.log.levels.INFO, { title = "Nvim-config" })
	end,
})
