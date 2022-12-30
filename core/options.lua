local opt = vim.opt

opt.fillchars = {
    vert = "│",
    fold = "⠀",
    eob = " ", 
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
}

vim.cmd [[set shell=powershell.exe\ -NoLogo shellpipe=\| shellxquote=]]
vim.cmd [[set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command]]
vim.cmd [[set shellredir=\|\ Out-File\ -Encoding\ UTF8]]

opt.pastetoggle = "<F12>"
opt.splitbelow = true
opt.splitright = true

opt.timeoutlen = 500
opt.updatetime = 500

opt.clipboard:append("unnamedplus")
opt.swapfile = false

opt.wildignorecase = true
opt.wildignore:append { '*.o','*.obj','*.dylib','*.bin','*.dll','*.exe' }
opt.wildignore:append { '*/.git/*','*/.svn/*','*/__pycache__/*','*/build/**' }
opt.wildignore:append { '*.jpg','*.png','*.jpeg','*.bmp','*.gif','*.tiff','*.svg','*.ico' }
opt.wildignore:append { '*.pyc','*.pkl' }
opt.wildignore:append { '*.DS_Store' }
opt.wildignore:append { '*.aux','*.bbl','*.blg','*.brf','*.fls','*.fdb_latexmk','*.synctex.gz','*.xdv' }

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.cmdheight = 1

opt.matchpairs:append {'<:>','「:」','『:』','【:】','“:”','‘:’','《:》'}

opt.number = true
opt.relativenumber = false

opt.ignorecase = true
opt.smartcase = true

opt.fileencoding = "utf-8"
opt.fileencodings = {'ucs-bom','utf-8','cp936','gb18030','big5','euc-jp','euc-kr','latin1'}

opt.linebreak = true
opt.showbreak = '↪'

opt.wildmode = "list:longest"

opt.scrolloff = 3

opt.mouse = "nic"
opt.mousemodel = "popup"

opt.showmode = false

opt.fileformats = {"unix", "dos"}

opt.confirm = true

opt.visualbell = true
opt.errorbells = false
opt.history = 500

opt.list = true

opt.autowrite = true

opt.title = true

opt.undofile = true

opt.shortmess:append('c')
opt.shortmess:append('S')
opt.shortmess:append('I')

opt.completeopt:append('menuone')
opt.completeopt:remove('preview')

opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 0

opt.complete:append('kspell')
opt.complete:remove('w')
opt.complete:remove('b')
opt.complete:remove('u')
opt.complete:remove('t')

opt.shiftround = true

opt.virtualedit = "block"

opt.formatoptions:append('mM')

opt.tildeop = true

opt.synmaxcol = 250
opt.startofline = false

vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }

opt.termguicolors = true

opt.guicursor = { 'n-v-c:block-Cursor/lCursor', 'i-ci-ve:ver25-Cursor2/lCursor2','r-cr:hor20','o:hor20'}

opt.signcolumn = "yes"

opt.wrap = false
opt.ruler = false
