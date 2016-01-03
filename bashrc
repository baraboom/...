HISTSIZE=5000
HISTFILESIZE=100000
shopt -s histappend
stty -ixon

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export MYSQL_PS1="mysql [\D]> "
