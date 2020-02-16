# ericonr's fish config related to embedded development

## Functions for programming with openocd

function openocdfast -a interface target
    openocd -f interface/$interface.cfg -f target/$target.cfg
end

function openocdstlink -a target
    openocdfast stlink $target
end

function openocdcmsis -a target
    openocdfast cmsis-dap $target
end

## Alias and function for debugging arm-none-eabi stuff with ugdb

alias arm-ugdb='ugdb --gdb arm-none-eabi-gdb'

function arm-ugdb-tmux
    tmux new-window -n ugdb-arm ugdb --gdb arm-none-eabi-gdb $argv
end

## Settings and alias for using the esp-idf tools from Espressif (ESP32)

set -x ESPIDF /opt/esp-idf
alias esp-idf='$ESPIDF/tools/idf.py -B /tmp/esp/(basename (pwd))'

## Aliases and function for can-utils related stuff

alias set-can='sudo ip link set up can0 type can bitrate 500000'
alias can0dump='candump can0'

function can0filt
    candump can0,$0:7ff
end

