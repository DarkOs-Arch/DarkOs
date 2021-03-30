export PS1="\[\e[1;49;32m\]\W\[\e[m\]\[\e[1;49;96m\]\\$\[\e[1;49;39m\] "
if [ -f /root/.zlogin ]; then
	./.zlogin
fi
