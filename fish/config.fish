alias cat=bat

if status is-interactive
    set fish_greeting
    alias lg=lazygit

    #zoxide (should be at the end)
    zoxide init fish | source

    oh-my-posh init fish --config ~/.config/fish/themes/catppuccin.omp.json | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# cargo
source "$HOME/.cargo/env.fish"

# opencode
fish_add_path /home/ithyx/.opencode/bin
