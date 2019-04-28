function openocdfast -a interface target
    openocd -f interface/$interface.cfg -f target/$target.cfg
end

function openocdstlink -a target
    openocdfast stlink $target
end

function openocdcmsis -a target
    openocdfast cmsis-dap $target
end

alias arm-ugdb='ugdb --gdb arm-none-eabi-gdb'

function arm-ugdb-tmux
    tmux new-window -n ugdb-arm ugdb --gdb arm-none-eabi-gdb $argv
end
