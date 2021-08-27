#!/bin/bash

# B = Basic Flask Project
# T = Basic Flask + TestProject 

TYPE="B"
FLAGS="flask environs ujson pytest"
SRC_FOLDER=".setup_python_project"

echo "---------- Starting Project ----------"

echo "... Creating Folder ($1)"

mkdir $(pwd)/$1 && cd $(pwd)/$1

echo "... Starting venv ($1)"

python -m venv venv && source venv/bin/activate

echo "... Installing Dependencies"

pip install -q $FLAGS

echo "... Creating requirements.txt"

pip freeze -l > requirements.txt

echo "... Creating .gitignore"

cat $HOME/$SRC_FOLDER/gitignore > .gitignore

echo "... Creating .env"

cat $HOME/$SRC_FOLDER/env > .env

echo "... Creating app folder"

mkdir app

echo "... Setup app"

touch app/__init__.py

echo "----------- Setup finished, have a good coding time :) -----------"
