#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# taken from https://fishshell.com/docs/current/commands.html#contains
for i in ~/.local/bin ~/.cargo/bin
    if not contains $i $PATH
        set PATH $PATH $i
    end
end

set -x LANG pt_BR.UTF-8
set -x DEBUGINFOD_URLS "https://debuginfod.s.voidlinux.org http://localhost:8002"
set -x DEBUGINFOD_TIMEOUT "5"
set -x TMUX_TMPDIR ~/.config
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh/agent
