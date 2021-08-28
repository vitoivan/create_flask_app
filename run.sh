#!/bin/bash

# B = Basic Flask Project
# T = Basic Flask + TestProject 

TYPE="B"
FLAGS="flask environs ujson pytest flake8"
SRC_FOLDER=".setup_python_project"

echo "---------- Starting Project ----------"
echo "" && echo "... Creating the folders"

mkdir $(pwd)/$1
mkdir $(pwd)/$1/app
mkdir $(pwd)/$1/tests
cd $(pwd)/$1

echo "" && echo "... Starting \".venv\($1)\""

python -m venv .venv && source ./.venv/bin/activate

echo "" && echo "... Installing the dependencies"

pip install --upgrade pip
pip install -q $FLAGS

echo "" && echo '... Creating "requirements.txt"'

pip freeze -l > requirements.txt

echo "" && echo '... Creating ".gitignore"'

cat $HOME/$SRC_FOLDER/gitignore > .gitignore

echo "" && echo '... Creating ".env"'

cat $HOME/$SRC_FOLDER/env > .env

echo "" && echo '... Setup "app" and "tests" folders'

touch app/__init__.py
touch app/main.py
touch app/*/__init__.py
touch tests/__init__.py

echo "... Configing the git repository" && echo ""

git init && git add . && git checkout -b main && git commit -m "Initial commit" && git checkout -b developer

echo ""
echo "----------- Setup finished, have a good coding time :) | #happyCoding -----------"
