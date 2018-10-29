#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export EDITOR=nano
PS1='[\u@\h \W]\$ '

#########
# ALIAS #
#########

alias ls='ls --color=auto'
alias grep='grep --color'
alias psax='ps ax | grep'
