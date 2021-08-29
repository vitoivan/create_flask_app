#!/bin/bash

ALIAS_NAME='createpy'
SRC='.setup_python_project'

ALIAS="alias $ALIAS_NAME='$HOME/$SRC/run.sh'"
SHELLRC=".bashrc"

if [ "$SHELL" == "/bin/zsh" ]; then
	SHELLRC=".zshrc"
fi

if [ `alias | grep $ALIAS_NAME | wc -l` == "$ALIAS_NAME='$HOME/$SRC/run.sh" ]; then
	echo $ALIAS >> $HOME/$SHELLRC
fi
