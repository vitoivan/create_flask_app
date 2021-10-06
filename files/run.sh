#!/bin/bash

# Directory name of this template (Will be in $HOME directory)
SRC_FOLDER=".setup_flask_project"

# All libs where will be installed per default
DEFAULT_FLAGS="flask environs ujson"
BASIC_FLAGS="flask"
TEST_FLAGS="pytest"
ORM_FLAGS="flask python-dotenv ujson flask-migrate flask_sqlalchemy sqlalchemy_utils psycopg2-binary Flask-HTTPAuth flask-jwt-extended"
FLAGS="$DEFAULT_FLAGS"

# Folder that will be created
DST="cfa_project"

# Possible Log mode
LOG=false
MODE="DEFAULT MODE"
APP_MODE="default_application"

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
	-o | --orm)
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
		MODE="TEST MODE"
		FLAGS="$FLAGS $TEST_FLAGS"
		shift
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

DST="$1"
echo "---------- Starting Project in ($MODE) ----------"

echo "... Creating the folders"
mkdir "$(pwd)/$DST"
mkdir "$(pwd)/$DST/app"
if [ "$MODE" == "TEST MODE" ]; then
	mkdir "$(pwd)/$DST/tests"
fi
cd $(pwd)/"$DST"

echo "... Starting \".venv\($DST)\""
python -m venv .venv && source ./.venv/bin/activate

echo "... Installing the dependencies"
pip install -q $FLAGS

echo '... Creating Files'
pip freeze -l > requirements.txt
cat $HOME/$SRC_FOLDER/gitignore > .gitignore
if [ "$MODE" != "BASIC MODE" ]; then
	cat $HOME/$SRC_FOLDER/env > .env
fi
cp -r $HOME/$SRC_FOLDER/$APP_MODE/* ./app
if [ "$MODE" == "TEST MODE" ]; then
	touch tests/__init__.py
fi

echo "... Configing the git repository"
git init -q
git add .
git commit -q -m "Initial commit"
git checkout -q -b developer

echo "----------- Setup finished, have a good coding time :) | #happyCoding -----------"

