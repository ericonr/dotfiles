#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# fish config related to text editing

set -x VISUAL nvim
set -x EDITOR nvim

alias clem='emacsclient -n'

alias temacs="emacs -nw"

function mdbat --argument-names file
    lowdown -Tterm $file | less -R
end

if not command -sq mdcat
	function mdcat --argument-names file
		lowdown -Tterm $file
	end
end
