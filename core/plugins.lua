require "plugins"
local builtin = require('telescope.builtin')
local wilder = require('wilder')

-- Telescope-Settings
vim.g.Telescope_WildIgnore = {
   dir = {'.git', '__pycache__', '.DS_Store'},
   file = {'*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png','*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz','*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp','*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf','*.mp3', '*.aac', '.xd'}
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Better-Escape-Settings
vim.g.better_escape_interval = 200

-- Vim-Xkbswitch-Settings
vim.g.XkbSwitchEnabled = 1

-- Vim-Markdown-Settings
vim.g.vim_markdown_conceal = 1
vim.g.tex_conceal = ''
vim.g.vim_markdown_math = 0

vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1
vim.g.vim_markdown_json_frontmatter = 1

vim.g.vim_markdown_toc_autofit = 1

-- Vim-Matchup-Settings
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_timeout = 100
vim.g.matchup_matchparen_insert_timeout = 30

vim.g.matchup_override_vimtex = 1
vim.g.matchup_delim_noskips = 0
vim.g.matchup_matchparen_offscreen = {
    method = {"popup"}
}

-- Asyncrun-Settings
vim.g.asyncrun_open = 6
vim.g.asyncrun_encs = 'gbk'

-- Nvim-gdb-Settings
vim.keymap.set('n', '<leader>dp', ':<C-U>GdbStartPDB python -m pdb %<CR>')

-- Vim-AutoSave-Settings
vim.g.auto_save = 1

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
