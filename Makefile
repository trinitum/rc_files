RCFILES=bashrc bash_profile gitconfig gitignore indent.pro inputrc perltidyrc tmux.conf zshenv zshrc

default:
	@echo "run make install EMAIL="name <e-mail>" if you want to install"
	exit 1

install:
	NAME=`echo $$EMAIL | sed 's/ <.*>//'` && \
	MAIL=`echo $$EMAIL | sed 's/^.*<\(.*\)>$$/\1/'` && \
	read -p "Using name $$NAME and e-mail $$MAIL, type 'yes' to confirm: " confirm && \
	[ x$$confirm = "xyes" ] && \
	for file in $(RCFILES); do \
		sed "s/\[%full_name%\]/$$NAME/" $$file | \
		sed "s/\[%email_address%\]/$$MAIL/" >~/.$$file; \
	done
	mkdir -p ~/.zsh && rm -rf ~/.zsh/* && cp -r zsh/* ~/.zsh/
	mkdir -p ~/.config/git && mv ~/.gitignore ~/.config/git/ignore
