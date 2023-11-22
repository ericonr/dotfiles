#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# fish config related to development in general

alias jpnb='jupyter-notebook'

alias cformat='clang-format -i -style=webkit'

function ugdb-tmux
    tmux new-window -n ugdb ugdb $argv
end

# Aliases for getting make and cargo to use temporary directories for building.
# Helps in keepign the SSD fresh.
alias maketmp='make BUILD_DIR=/tmp/(basename (pwd))'
alias cargotmp='env CARGO_TARGET_DIR=/tmp/cargo/(basename (pwd)) cargo'

alias rebase-up='git pull upstream master --rebase --autostash'

alias gg='git grep'

alias podman-i='podman run --rm --detach-keys="ctrl-a,d" -t -a stdin -a stdout -a stderr --mount type=bind,source=$PWD,destination=$PWD --workdir=$PWD'

function statusgit --argument show \
    --description "Show git status for all directories in the current directory. Requires omf."
    if test -z $show
        set show_status false
    else
        set show_status true
    end

    set_color -o
    printf "Checking git status: "
    if $show_status
        printf "showing all status!"
    end
    printf "\n\n"
    set_color normal

    for dir in ./*/
        cd "$dir"

        if git_is_repo
            set final 0

            set_color -o
            printf "$dir is:\n"
            set_color normal

            if git_is_dirty
                printf "  dirty\n"
                set final 1
            end
            if git_is_staged
                printf "  staged\n"
                set final 1
            end
            if git_is_touched
                printf "  touched\n"
                set final 1
            end

            if test $final = 0
                printf "  clean\n"
                if $show_status
                    git status
                end
                printf "\n"
            else
                git status
                printf "\n"
            end

        end

        cd -
    end
end

