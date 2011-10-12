RCFILES=bashrc bash_profile gitconfig gitignore indent.pro inputrc perltidyrc screenrc
EMAIL:=nobody <noemail>

default:
	@echo "run make install -DEMAIL="name <e-mail>" if you want to install"
	exit 1

install:
	NAME=`perl -e'print "$(EMAIL)" =~ /^(.*) <.*$$/'`; \
	MAIL=`perl -e'print "$(EMAIL)" =~ /<(.*)>/'`; \
	for file in $(RCFILES); do \
		cp $$file ~/.$$file; \
		sed -i "s/\[%full_name%\]/$$NAME/" ~/.$$file; \
		sed -i "s/\[%email_address%\]/$$MAIL/" ~/.$$file; \
	done
