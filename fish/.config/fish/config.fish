# taken from https://fishshell.com/docs/current/commands.html#contains
for i in ~/.local/bin ~/.cargo/bin /opt/hipSYCL/CUDA/bin
    if not contains $i $PATH
        set PATH $PATH $i
    end
end

set -x VISUAL nvim
