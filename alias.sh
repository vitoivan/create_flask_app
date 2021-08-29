#!/bin/bash

ALIAS_NAME='createpy'
ALIAS="alias $ALIAS_NAME='$HOME/.setup_python_project/run.sh'"
SHELLRC=".bashrc"

if [ "$SHELL" == "/bin/zsh" ]; then
	SHELLRC=".zshrc"
fi

if [ `alias | grep $ALIAS_NAME | wc -l` == 0 ]; then
	echo $ALIAS >> $HOME/$SHELLRC
fi
source $HOME/$SHELLRC
