function __fish_complete_do_not_subcommand
    __fish_complete_subcommand --commandline $args
end
complete -c dis -x -a "(__fish_complete_do_not_subcommand)"
