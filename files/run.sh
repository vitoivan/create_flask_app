#!/bin/bash

# Directory name of this template (Will be in $HOME directory)
SRC_FOLDER=".setup_flask_project"

# All libs where will be installed per default
BASIC_FLAGS="flask"
DEFAULT_FLAGS="$BASIC_FLAGS python-dotenv"
TEST_FLAGS="pytest"
ORM_FLAGS="$DEFAULT_FLAGS flask-migrate flask_sqlalchemy sqlalchemy_utils psycopg2-binary"
FLAGS="$DEFAULT_FLAGS"

# Folder that will be created
DEFAULT_DST="cfa_project" 
DST="$DEFAULT_DST"

# Possible Log mode
LOG=false

# Modes configs
MODE="DEFAULT MODE"
APP_MODE="default_application"
TEST_MODE=false

LOG
helper_message()
{
	echo "Usage: cfa [options] [project_name]"
	echo "cfa - create and default python-flask repository"
	echo " "
	echo "options:"
	echo "-h, --help                show this message"
	echo "-t, --test                append a test environment for your project (can be used with other mode)"
	echo "-b, --basic               create just an basic structure for a flask project"
	echo "-l, --log                 create an error file log"
	echo "-d, --default             default mode, this mode create a structure based on the Flask Factory pattern and MVC"
	echo "-o, --orm                 orm mode, this mode create a structure based on the Flask Factory using ORM"
}

for arg in "$@"
do
	case $arg in
	-b|--basic)
		MODE="BASIC MODE"
		APP_MODE="basic_application"
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
	-o|--orm)
		FLAGS="$ORM_FLAGS"
		MODE="ORM MODE"
		APP_MODE="orm_application"
		shift
		;;
	-h|--help)
		helper_message
		exit 1
		;;
	esac
done

for arg in "$@"
do
	case $arg in
	-t|--test)
		TEST_MODE=true
		FLAGS="$FLAGS $TEST_FLAGS"
		shift
		;;
	esac
done

if [ "$LOG" == "true" ]; then
	exec 2> cfa.log
fi
	
if [ "$1" != "" ]; then
	DST="$1"
else
	DST="$DEFAULT_DST"
fi

echo "---------- Starting Project in ($MODE) with (TEST_MODE = $TEST_MODE) ----------"

echo "... Creating folders"
mkdir "$(pwd)/$DST"
mkdir "$(pwd)/$DST/app"

cd $(pwd)/"$DST"

echo "... Starting \".venv\($DST)\""
python -m venv .venv && source ./.venv/bin/activate

echo "... Installing dependencies"
pip install -q $FLAGS

echo '... Creating Files'
pip freeze -l > requirements.txt
cat $HOME/$SRC_FOLDER/gitignore > .gitignore


# Creating .env file
if [ "$MODE" == "ORM MODE" ]; then
	cat $HOME/$SRC_FOLDER/env_orm > .env
else
	cat $HOME/$SRC_FOLDER/env_basic > .env
fi

# Copy all files to DST folder
cp -r $HOME/$SRC_FOLDER/$APP_MODE/* ./app


# If in test mode, then create a test folder 
if [ "$TEST_MODE" == "true" ]; then
	cp -r $HOME/$SRC_FOLDER/tests  ./
fi

echo "... Configing the git repository"
git init -q
git add .
git commit -q -m "Initial commit"
git checkout -q -b developer

echo "----------- Setup finished, have a good coding time :) | #happyCoding -----------"