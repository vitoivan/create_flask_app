#!/bin/bash

# All libs where will be installed per default
FLAGS="flask environs ujson pytest"

# Directory name of this template (Will be in $HOME directory)
SRC_FOLDER=".setup_python_project"

echo "---------- Starting Project ----------"

echo "... Creating the folders"
mkdir $(pwd)/$1
mkdir $(pwd)/$1/app
mkdir $(pwd)/$1/tests
cd $(pwd)/$1

echo "... Starting \".venv\($1)\""
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
git init && git add . && git commit -m "Initial commit" && git checkout -b developer

echo "----------- Setup finished, have a good coding time :) | #happyCoding -----------"
