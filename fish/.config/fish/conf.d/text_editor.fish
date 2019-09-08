alias clem='emacsclient -n'
alias sudoclem='sudo emacsclient -n'

alias temacs="emacs -nw"
alias stemacs="sudo emacs -nw"

function mdbat --argument-names file
	mdcat $file | bat -p
end

