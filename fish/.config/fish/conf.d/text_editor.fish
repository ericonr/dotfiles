alias clem='emacsclient -n'
alias sudoclem='sudo emacsclient -n'

alias temacs="emacs -nw"
alias stemacs="sudo emacs -nw"

function pcmark
    pulldown-cmark < $argv > $argv.html
end
