local plugins = require('plugins')
local wilder = require('wilder')

-- Telescope-Settings
vim.g.Telescope_WildIgnore = {
  dir = {'.git', '__pycache__', '.DS_Store'},
  file = {'*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
  '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
  '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
  '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf',
  '*.mp3', '*.aac', '.xd'}
}

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {silent = true})

-- better-escape.vim settings
vim.g.better_escape_interval = 200

-- vim-xkbswitch settings
vim.g.XkbSwitchEnabled = 1

-- vim-markdown settings
-- Disable header folding
vim.g.vim_markdown_folding_disabled = 1

-- Whether to use conceal feature in markdown
vim.g.vim_markdown_conceal = 1

-- Disable math tex conceal and syntax highlight
vim.g.tex_conceal = ''
vim.g.vim_markdown_math = 0

-- Support front matter of various format
vim.g.vim_markdown_frontmatter = 1 -- for YAML format
vim.g.vim_markdown_toml_frontmatter = 1 -- for TOML format
vim.g.vim_markdown_json_frontmatter = 1 -- for JSON format

-- Let the TOC window autofit so that it doesn't take too much space
vim.g.vim_markdown_toc_autofit = 1

-- Map s to nop since s in used by vim-sandwich. Use cl instead of s.
vim.api.nvim_set_keymap("n", "s", "<Nop>", {})
vim.api.nvim_set_keymap("o", "s", "<Nop>", {})

-- Improve performance
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_timeout = 100
vim.g.matchup_matchparen_insert_timeout = 30

-- Enhanced matching with matchup plugin
vim.g.matchup_override_vimtex = 1

-- Whether to enable matching inside comment or string
vim.g.matchup_delim_noskips = 0

-- Show offscreen match pair in popup window
vim.g.matchup_matchparen_offscreen = {method = "popup"}

-- Start GDB with Python debugger (PDB)
vim.api.nvim_set_keymap("n", "<leader>dp", ":<C-U>GdbStartPDB python -m pdb %<CR>", {})

-- Wilder-Settings
wilder.setup({
    modes = {':', '/', '?'},
    next_key = '<Tab>',
    previous_key = '<S-Tab>',
    accept_key = '<C-y>',
    reject_key = '<C-e>'
})

wilder.set_option('pipeline', {
    wilder.branch(
       wilder.cmdline_pipeline({
           language = 'python',
           fuzzy = 1,
           sorter = wilder.python_difflib_sorter(),
           debounce = 30
       }),
       wilder.vim_search_pipeline(),
       wilder.python_search_pipeline({
           pattern = wilder.python_fuzzy_pattern(),
           sorter = wilder.python_difflib_sorter(),
           engine = 're',
           debounce = 30
       })
    )
})

wilder.set_option('renderer', wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
    max_height = 15,
    highlights = {
        accent = wilder.make_hl('WilderAccent', 'Pmenu', {{}, {}, {foreground = "#f4468f"}})
    },
    left = {' ', wilder.popupmenu_devicons()},
    right = {' ', wilder.popupmenu_scrollbar()},
    apply_incsearch_fix = 0,
}))

