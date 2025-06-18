" :nnoremap <F5>d :!cd macha; cargo run<enter>
" :nnoremap <F5>r :!cd macha; cargo run --release<enter>
:nnoremap <C-b> :call TermFocus(12)<enter> cd macha; cargo build<enter><Esc>

lua << EOF

local dap = require 'dap'
dap.configurations.rust = {{
	name = 'macha',
	type = 'lldb',
	request = 'launch',
	program = vim.fn.getcwd()..'/target/debug/macha',
	cwd = '${workspaceFolder}/macha',
	stopOnEntry = false,
	args = {},

	initCommands = {'cargo build -p macha'}
	}}

EOF

