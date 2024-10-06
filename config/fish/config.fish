if status is-interactive
	set fish_greeting
	source /usr/share/powerline/bindings/fish/powerline-setup.fish
	powerline-setup
	if test (tty) = "/dev/tty1"
		startx &> /dev/null
	end
end
