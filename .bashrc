#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '



source /home/altor/.env_setting
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/altor/usr/bin:/opt/riak/bin

#Opam configuration
. /home/altor/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Android sdk configuration

export PATH=${PATH}:/opt/android-sdk/platform-tools:/opt/android-sdk/tools

##########
# HADOOP #
##########

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export HADOOP_INSTALL=~/usr/hadoop-2.5.2
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
export PATH=${PATH}:$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin
#HADOOP VARIABLES END 

#########
# ALIAS #
#########


alias ls='ls --color=auto'
alias grep='grep --color'
alias psax='ps ax | grep'

alias shutdown='sudo shutdown -f now'
alias rerl='erl -pa ./ebin -pa ./deps/*/ebin'
alias vpn='sudo openvpn --config ~/.openvpn/openvpn_etu.conf --script-security 2 --up /etc/openvpn/update-resolv-conf --down /etc/openvpn/update-resolv-conf'
alias td='todo.sh'
alias id='cat ~/Notes/Technique/identifiant.md'

alias lille1_env='export https_proxy="cache.univ-lille1.fr:3128" && export http_proxy="cache.univ-lille1.fr:3128"'
