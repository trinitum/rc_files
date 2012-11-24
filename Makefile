RCFILES=bashrc bash_profile gitconfig gitignore indent.pro inputrc perltidyrc screenrc

default:
	@echo "run make install EMAIL="name <e-mail>" if you want to install"
	exit 1

install:
	NAME=`perl -e'print q($(EMAIL)) =~ /^(.*) </'`; \
	MAIL=`perl -e'print q($(EMAIL)) =~ /<(.*)>/'`; \
	for file in $(RCFILES); do \
		sed "s/\[%full_name%\]/$$NAME/" $$file | \
		sed "s/\[%email_address%\]/$$MAIL/" >~/.$$file; \
	done
