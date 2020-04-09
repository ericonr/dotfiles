#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# fish config related to text editing

set -x VISUAL nvim

alias clem='emacsclient -n'

alias temacs="emacs -nw"

function mdbat --argument-names file
    mdcat $file | bat -p
end

