#!/bin/bash

ALIAS_NAME="cfa"
SRC=".setup_python_project"

ALIAS="alias $ALIAS_NAME='f(){ $HOME/$SRC/run.sh \$@; }; f'"
SHELLRC=".bashrc"

if [ "$SHELL" == "/bin/zsh" ]; then
	SHELLRC=".zshrc"
fi

echo $(cat $HOME/$SHELLRC | grep $ALIAS_NAME | wc -l)
if [ "$(cat $HOME/$SHELLRC | grep $ALIAS_NAME | wc -l)" == 0 ]; then
    echo $ALIAS >> $HOME/$SHELLRC
fi
