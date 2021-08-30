#!/bin/bash

# Directory name of this template (Will be in $HOME directory)
SRC_FOLDER=".setup_flask_project"

# All libs where will be installed per default
DEFAULT_FLAGS="flask environs ujson"
BASIC_FLAGS="flask environs"
FLAGS="$DEFAULT_FLAGS"
TEST_FLAGS="$DEFAULT_FLAGS pytest"

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
	echo "-d, --default             default mode, this mode create a structure based on the Flask Factory pattern"
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
		FLAGS="$BASIC_FLAGS"
		shift
		;;
	-l|--log)
		LOG=true
		shift
		;;
	-d|--default)
		FLAGS="$DEFAULT_FLAGS"
		MODE="DEFAULT MODE"
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

#Get the destination and current folders:
DST=$1
PWD=$(pwd)

echo "---------- Starting Project in ($MODE) ----------"
echo "In $PWD/$DST:"


echo "... Creating the folders"
mkdir "$PWD/$DST"
mkdir "$PWD/$DST/app"

if [ "$MODE" == "TEST MODE" ]; then
	mkdir "$PWD/$DST/tests"
fi
cd "$PWD/$DST"

echo "... Starting \".venv\" in $PWD/$DST/.venv"
python -m venv .venv && source ./.venv/bin/activate

echo "... Installing the dependencies"
pip install -q $FLAGS

echo '... Creating Files'
pip freeze -l > requirements.txt
cat $HOME/$SRC_FOLDER/gitignore > .gitignore
cat $HOME/$SRC_FOLDER/env > .env
cat $HOME/$SRC_FOLDER/initapp > app/__init__.py
touch app/main.py
if [ "$MODE" == "TEST MODE" ]; then
	touch tests/__init__.py
fi

echo "... Configing the git repository"
git init -q
git add .
git commit -q -m "Initial commit"
git checkout -q -b developer

echo "----------- Setup finished, have a good coding time :) | #happyCoding -----------"

