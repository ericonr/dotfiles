#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# fish config for everyday utilities

## Aliases for single column ls
alias lk='ls -1'
alias kl='ls -1'

## Alias to make `la` useful, hiding ./ and ../
alias lla='ls -lA'

## Same as above, without the extra details
alias la='ls -A'

function rmstar --description "Remove starship prompt."
    alias fish_prompt='echo (pwd) "> "'
end

function addstar --description "Add starship prompt back."
    source ~/.config/fish/functions/fish_prompt.fish
end

alias pre='cd ../'

alias weather='curl wttr.in/'

## Aliases for quick grepping
alias rgmod='lsmod | grep -i'
alias rug='ug --ignore-files --sort -nr'

function watchps --description "Watch process(es)"
	set _p (pgrep -f "$argv[1]")
	[ -z "$_p" ]
	and return 1

	watch -n.1 ps -o pid,%cpu,nlwp,vsz,sz $_p
end

function randpw -a digits \
    --description "Generates a random password with the specified number of digits, and copies it into the Wayland buffer."
    openssl rand -base64 $digits | wl-copy
end

function pdfunlock --description "Unlocks all PDF files in a directory."
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

