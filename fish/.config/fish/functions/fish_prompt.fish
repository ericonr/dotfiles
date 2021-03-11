function fish_prompt
	set -l _exit_status $status
	set -l _prompt_args

	if [ -n "$CHROOTED" ]
		set -a _prompt_args -c
	end

	ep $_prompt_args -j (count (jobs --pid)) -e $_exit_status -d $CMD_DURATION
end
