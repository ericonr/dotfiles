# ericonr's fish config related to text editing

set -x VISUAL nvim

alias clem='emacsclient -n'

alias temacs="emacs -nw"

function mdbat --argument-names file
	mdcat $file | bat -p
end

