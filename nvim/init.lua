local debug = function(_)
  print('DEBUG REACHED')
end

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('morhetz/gruvbox')
Plug('catppuccin/nvim', {as = 'catppuccin-mocha'})

Plug('neovim/nvim-lspconfig')
Plug('ms-jpq/coq_nvim', {branch = 'coq'})
Plug('ms-jpq/coq.artifacts', {branch = 'artifacts'})
Plug('ms-jpq/coq.thirdparty', {branch = '3p'})

Plug('nvim-lua/plenary.nvim')
Plug('kyazdani42/nvim-web-devicons')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-neo-tree/neo-tree.nvim', { branch = "v2.x" })

Plug('mfussenegger/nvim-dap')

Plug('andweeb/presence.nvim')

Plug('LucHermitte/lh-vim-lib')
Plug('LucHermitte/local_vimrc')

Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-ui-select.nvim')
Plug('nvim-telescope/telescope-dap.nvim')
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('LinArcX/telescope-command-palette.nvim')

Plug('lewis6991/gitsigns.nvim')

Plug('kdheepak/lazygit.nvim')

Plug('saecki/crates.nvim', { tag = 'v0.3.0' })

Plug('xiyaowong/nvim-transparent')

vim.call('plug#end')

-- basic settings
vim.api.nvim_command('set mouse=v')
vim.api.nvim_command('set tabstop=4')
vim.api.nvim_command('set shiftwidth=4')
vim.api.nvim_command('set expandtab')
vim.api.nvim_command('set autoread')
vim.api.nvim_command('set termguicolors')

-- basic mapping
vim.keymap.set('n', '<C-C>', ':noh<CR>')
vim.keymap.set('n', '<A-Left>', '<C-o>')
vim.keymap.set('n', '<A-Right>', '<C-I>')

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
local dap = require 'dap'
local dap_widgets = require 'dap.ui.widgets'
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

-- DAP mappings
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint)
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F3>', function() dap_widgets.centered_float(dap_widgets.scopes) end)

-- setup theme
vim.api.nvim_command('set signcolumn=yes')
vim.api.nvim_command('set number')
-- vim.api.nvim_command('autocmd vimenter * ++nested colorscheme gruvbox')
vim.cmd.colorscheme "catppuccin"

-- whitelist dev to load local vimrc
vim.fn['lh#local_vimrc#munge']('whitelist', vim.env['HOME']..'/dev')
vim.fn['lh#local_vimrc#munge']('blacklist', vim.env['HOME']..'/tools/nvim-config')

-- setup neo-tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
local neotree = require 'neo-tree'
neotree.setup({
    popup_border_style = "rounded"
})

-- add discord rich presence
local discord = require 'presence'
discord:setup({
  neovim_image_text = 'Neovim'
})

-- setup lsp
local lsp = require 'lspconfig'

vim.api.nvim_command([[let g:coq_settings = { 'auto_start': 'shut-up' }]])
local coq = require 'coq'

-- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { buffer=bufnr, noremap=true, silent=true }
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
	  vim.lsp.buf.format {{boffopts, async = true}}
  end, bufopts)
end

local capabilities = {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy"
			}
		}
	}
}
capabilities = coq.lsp_ensure_capabilities(capabilities)
-- print(vim.inspect(capabilities))

lsp.rust_analyzer.setup(capabilities)
lsp.clangd.setup(capabilities)
lsp.angularls.setup(capabilities)
lsp.tsserver.setup(capabilities)
lsp.pyright.setup(capabilities)

-- Hook telescope
local telescope = require 'telescope'
local telescope_themes = require 'telescope.themes'
telescope.setup {
  extensions = {
    ['ui-select'] = {telescope_themes.get_dropdown {}},
    file_browser = {theme = 'ivy'},
    command_palette = {
      {'File',
        {'Diagnostics', ':Telescope diagnostics'},
        {'Fuzzy finder', ':Telescope grep_string'},
        {'File browser', ':Telescope file_browser'},
        {'Open buffers', ':Telescope buffers'},
      },
      {'Git',
        {'Telescope git stash', ':lua require"telescope.builtin".git_stash()'},
        {'Telescope git branches', ':lua require"telescope.builtin".git_branches()'},
        {'Telescope git commits [buffer]', ':lua require"telescope.builtin".git_bcommits()'},
        {'Telescope git commits [global]', ':lua require"telescope.builtin".git_commits()'},
        {'Telescope git status', ':lua require"telescope.builtin".git_status()'},
        {'Telescope lazygit', ':lua require"telescope".extensions.lazygit.lazygit()'},
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

vim.keymap.set('n', '<C-P>', ':Telescope command_palette<enter>')

-- Setup Gitsigns
local gitsigns = require 'gitsigns'
gitsigns.setup()

-- setup lazygit
vim.g.lazygit_floating_window_use_plenary = 1
vim.api.nvim_create_autocmd("BufEnter", {command = ':lua require"lazygit.utils".project_root_dir()'})

-- setup TreeSitter
require'nvim-treesitter.configs'.setup {
    auto_install = true,
	ensure_installed = {"rust", "glsl"},
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
