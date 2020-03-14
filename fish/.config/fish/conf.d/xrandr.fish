#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# fish config related to xrandr

function list-display --description 'List available display interfaces from xrandr.'
    xrandr | sed -n '/connected/p'
end

function conf-display --argument-names width height interface
    set MODELINE (cvt $width $height | sed -e '/Modeline*/!d' -e 's/Modeline //')
    set RESOL_REFRESH (echo $MODELINE | awk -F'"' '{print $2}')

    eval xrandr --newmode $MODELINE
    eval xrandr --addmode $interface $RESOL_REFRESH
    eval xrandr --output $interface --mode $RESOL_REFRESH

    if $status
        echo "Succesfully configured $interface for displaying $width x $height video!"
    else
        echo "There was an error!"
    end

end

