alias lk='ls -1'
alias kl='ls -1'

alias weather='curl wttr.in/'

function pdfunlock
    # command taken from https://mandrivausers.org/index.php?/topic/79354-saving-pdf-file-without-password-solved/
    echo "Password: $argv[1]"
    
    mkdir -p unlocked
    for file in *.pdf
        rm -f "unlocked/$file"
        pdftk "$file" input_pw "$argv[1]" output "unlocked/$file"
        if test $status = 0
            echo "Unlocked: $file!"
        else
            echo "Problem unlocking: $file."
        end
    end
end

function starttmux
    emacs --daemon
    tmux
end

