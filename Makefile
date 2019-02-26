RCFILES=bashrc bash_profile gitconfig gitignore indent.pro inputrc perltidyrc tmux.conf zshrc

default:
	@echo "run make install EMAIL="name <e-mail>" if you want to install"
	exit 1

install:
	NAME=`perl -e'print q($(EMAIL)) =~ /^(.*) </'`; \
	MAIL=`perl -e'print q($(EMAIL)) =~ /<(.*)>/'`; \
	read -p "Using name $$NAME and e-mail $$EMAIL, type 'yes' to confirm: " confirm && \
	[ x$$confirm = "xyes" ] && \
	for file in $(RCFILES); do \
		sed "s/\[%full_name%\]/$$NAME/" $$file | \
		sed "s/\[%email_address%\]/$$MAIL/" >~/.$$file; \
	done
	mkdir -p ~/.config/git && mv ~/.gitignore ~/.config/git/ignore
	[ -d ~/.oh-my-zsh ] || git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
