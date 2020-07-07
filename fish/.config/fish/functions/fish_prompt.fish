if [ $CHROOTED ]
	alias fish_prompt='echo "[chroot]" (pwd) "> "'
else
	source ("starship" init fish --print-full-init | psub)
end
