alias set-can='sudo ip link set up can0 type can bitrate 500000'
alias can0dump='candump can0'

function can0filt
    candump can0,$0:7ff
end
