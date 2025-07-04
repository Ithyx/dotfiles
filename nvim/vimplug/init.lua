vim.cmd([[
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]])

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('catppuccin/nvim', { as = 'catppuccin-mocha' })

Plug('VonHeikemen/lsp-zero.nvim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')

Plug('nvim-lua/plenary.nvim')
Plug('kyazdani42/nvim-web-devicons')
Plug('folke/snacks.nvim')
Plug('mikavilpas/yazi.nvim')

Plug('nvim-neotest/nvim-nio')
Plug('mfussenegger/nvim-dap')
Plug('rcarriga/nvim-dap-ui')

Plug('LucHermitte/lh-vim-lib')
Plug('LucHermitte/local_vimrc')

Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-ui-select.nvim')
Plug('nvim-telescope/telescope-dap.nvim')
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('LinArcX/telescope-command-palette.nvim')

Plug('rcarriga/nvim-notify')

Plug('lewis6991/gitsigns.nvim')
Plug('kdheepak/lazygit.nvim')

Plug('saecki/crates.nvim', { tag = 'v0.3.0' })

Plug('xiyaowong/nvim-transparent')

Plug('vim-scripts/dbext.vim')
Plug('kaarmu/typst.vim')

Plug('nvim-lualine/lualine.nvim')

vim.call('plug#end')

-- basic settings
vim.api.nvim_command('set mouse=v')
vim.api.nvim_command('set tabstop=4')
vim.api.nvim_command('set shiftwidth=4')
vim.api.nvim_command('set expandtab')
vim.api.nvim_command('set autoread')
vim.api.nvim_command('set termguicolors')

-- custom icons
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
    },
})

vim.fn.sign_define("DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "󰌵", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })


-- basic mapping
vim.keymap.set('n', '<C-C>', ':noh<CR>')
vim.keymap.set('n', '<A-Left>', '<C-o>')
vim.keymap.set('n', '<A-Right>', '<C-I>')
vim.keymap.set('n', '<C-Down>', 'gj')
vim.keymap.set('n', '<C-Up>', 'gk')

-- setup terminal mode
vim.api.nvim_command([[
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
function! TermFocus(height)
    if win_gotoid(g:term_win)
        startinsert!
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
]])
vim.keymap.set('n', '<A-t>', ':call TermToggle(12)<CR>')
vim.keymap.set('i', '<A-t>', '<Esc>:call TermToggle(12)<CR>')
vim.keymap.set('t', '<A-t>', '<C-\\><C-n>:call TermToggle(12)<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- setup DAP
local dap_ui = require 'dapui'
dap_ui.setup()

local dap = require 'dap'
dap.listeners.after.event_initialized['dapui_config'] = function()
    dap_ui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dap_ui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dap_ui.close()
end

vim.keymap.set('n', '<F9>', dap.toggle_breakpoint)
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)

-- setup theme
vim.api.nvim_command('set signcolumn=yes')
vim.api.nvim_command('set number')
vim.cmd.colorscheme "catppuccin"

-- whitelist dev to load local vimrc
vim.fn['lh#local_vimrc#munge']('whitelist', vim.env['HOME'] .. '/dev')
vim.fn['lh#local_vimrc#munge']('blacklist', vim.env['HOME'] .. '/tools/nvim-config')

-- setup snacks
local snacks = require 'snacks'
snacks.setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
})

-- setup yazi
local yazi = require 'yazi'
yazi.setup({
    -- config goes here
    open_for_directories = true,
})

vim.keymap.set('n', '<C-b>', function() yazi.yazi() end, { noremap = true, silent = true, desc = "Open yazi" })
vim.g.loaded_netrwPlugin = 1

-- setup nvim_cmp
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

--- Use an on_attach function to only map the following keys
--- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-g>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('i', '<C-g>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<C-l>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

    vim.keymap.set('n', '<C-s>', function()
        vim.lsp.buf.format { { boffopts, async = true } }
    end, bufopts)
end

local capabilities = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            }
        }
    },
}

--- Mappings
--- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Setup LSP-zero
local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup(capabilities)
lspconfig.ccls.setup(capabilities)
lspconfig.ts_ls.setup(capabilities)
lspconfig.angularls.setup(capabilities)
lspconfig.glslls.setup(capabilities)
lspconfig.jedi_language_server.setup(capabilities)

-- Hook telescope
local telescope = require 'telescope'
local telescope_themes = require 'telescope.themes'
telescope.setup {
    extensions = {
        ['ui-select'] = { telescope_themes.get_dropdown {} },
        file_browser = { theme = 'ivy' },
        command_palette = {
            { 'File',
                { 'Open buffers',  ':Telescope buffers' },
                { 'File browser',  ':Telescope file_browser' },
                { 'Symbol search', ':lua require"telescope.builtin".lsp_workspace_symbols()' },
                { 'Global search', ':lua require"telescope.builtin".live_grep()' },
                { 'Diagnostics',   ':Telescope diagnostics' },
            },
            { 'Notifications',
                { 'View past notifications', ':Telescope notify' },
            },
            { 'Correct',
                { 'Correct word under cursor', ':lua require"telescope.builtin".spell_suggest()' },
                { 'Enable correction',         ':setlocal spell spelllang=fr,en' },
            },
            { 'Git',
                { 'Telescope git stash',            ':lua require"telescope.builtin".git_stash()' },
                { 'Telescope git branches',         ':lua require"telescope.builtin".git_branches()' },
                { 'Telescope git commits [buffer]', ':lua require"telescope.builtin".git_bcommits()' },
                { 'Telescope git commits [global]', ':lua require"telescope.builtin".git_commits()' },
                { 'Telescope git status',           ':lua require"telescope.builtin".git_status()' },
                { 'Telescope lazygit',              ':lua require"telescope".extensions.lazygit.lazygit()' },
            },
        }
    }
}
telescope.load_extension('ui-select')
telescope.load_extension('file_browser')
telescope.load_extension('command_palette')
telescope.load_extension('dap')
telescope.load_extension('lazygit')

local telescope_handlers = require('telescope.builtin')
vim.lsp.handlers["textDocument/references"] = telescope_handlers.lsp_references
vim.lsp.handlers["textDocument/definition"] = telescope_handlers.lsp_definitions
vim.lsp.handlers["textDocument/typeDefinition"] = telescope_handlers.lsp_type_definitions
vim.lsp.handlers["textDocument/implementation"] = telescope_handlers.lsp_implementations

vim.keymap.set('n', 'z=', ':lua require"telescope.builtin".spell_suggest()<enter>')

vim.keymap.set('n', '<C-P>', ':Telescope command_palette<enter>')
vim.keymap.set('n', '<A-g>', ':lua require"telescope".extensions.lazygit.lazygit()<enter>')

-- setup nvim-notify
vim.notify = require 'notify'
vim.notify.setup {
    background_colour = "#000000"
}

-- Setup Gitsigns
local gitsigns = require 'gitsigns'
gitsigns.setup()

-- setup lazygit
vim.g.lazygit_floating_window_use_plenary = 1
vim.api.nvim_create_autocmd("BufEnter", { command = ':lua require"lazygit.utils".project_root_dir()' })

-- setup TreeSitter
require 'nvim-treesitter.configs'.setup {
    auto_install = true,
    ensure_installed = { "rust", "glsl" },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}

--- Add nu parser
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.nu = {
    install_info = {
        url = "https://github.com/nushell/tree-sitter-nu",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "nu",
}

-- setup some extensions
vim.filetype.add {
    extension = {
        frag = 'glsl',
        vert = 'glsl',
        comp = 'glsl',
    }
}

-- Setup crates.nvim
local crates = require 'crates'
crates.setup()

-- Setup transparent
local transparent = require 'transparent'
transparent.setup({})
-- transparent.clear_prefix('lualine')

-- Setup lualine
local lualine = require 'lualine'
lualine.setup {
    options = {
        theme = 'wombat'
    },
    sections = {
        lualine_c = { { 'filename', file_status = true, path = 1 } }
    },
    inactive_sections = {
        lualine_c = { { 'filename', file_status = true, path = 1 } }
    },
    extensions = { 'toggleterm' }
}
