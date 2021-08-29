#!/bin/bash

# Directory name of this template (Will be in $HOME directory)
SRC_FOLDER=".setup_python_project"

# All libs where will be installed per default
DEFAULT_FLAGS="flask environs ujson"
TEST_FLAGS="$DEFAULT_FLAGS pytest"
FLAGS="$DEFAULT_FLAGS"

# Folder that will be created
DST="cfa_project"

# Possible Log mode
LOG=false
MODE="DEFAULT MODE"

helper_message()
{
	echo "Usage: cfa [options] [project_name]"
	echo "cfa - create and default python-flask repository"
	echo " "
	echo "options:"
	echo "-h, --help                show this message"
	echo "-t, --test                create and setup a default test environment"
	echo "-b, --basic               create just an basic structure for a flask project"
	echo "-l, --log                 create an error file log"
}

for arg in "$@"
do
	case $arg in
	-t|--test)
		MODE="TEST MODE"
		FLAGS="$TEST_FLAGS"
		shift
		;;
	-b|--basic)
		MODE="BASIC MODE"
		FLAGS="$TEST_FLAGS"
		shift
		;;
	-l|--log)
		LOG=true
		shift
		;;
	-h|--help)
		helper_message
		exit 1
		;;
	esac
done

if [ "$LOG" == "true" ]; then
	exec 2> cfa.log
fi
	
if [ "$1" == "" ]; then
	helper_message
	exit 1
fi

DST=$1
echo "---------- Starting Project in ($MODE) ----------"

echo "... Creating the folders"
mkdir $(pwd)/$DST
mkdir $(pwd)/$DST/app
if [ "$MODE" == "TEST MODE" ]; then
	mkdir $(pwd)/$DST/tests
fi
cd $(pwd)/$DST

echo "... Starting \".venv\($DST)\""
python -m venv .venv && source ./.venv/bin/activate

echo "... Installing the dependencies"
pip install -q $FLAGS

echo '... Creating Files'
pip freeze -l > requirements.txt
cat $HOME/$SRC_FOLDER/gitignore > .gitignore
cat $HOME/$SRC_FOLDER/env > .env
cat $HOME/$SRC_FOLDER/initapp > app/__init__.py
touch app/main.py
touch tests/__init__.py

echo "... Configing the git repository"
git init -q
git add .
git commit -q -m "Initial commit"
git checkout -q -b developer

echo "----------- Setup finished, have a good coding time :) | #happyCoding -----------"

