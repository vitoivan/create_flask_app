#!/bin/bash

# B = Basic Flask Project
# T = Basic Flask + TestProject 

TYPE="B"
FLAGS="flask environs ujson pytest flake8"
SRC_FOLDER=".setup_python_project"

echo "---------- Starting Project ----------"

echo "... Creating Folders ($1)"

mkdir $(pwd)/$1
mkdir $(pwd)/$1/app
mkdir $(pwd)/$1/tests
cd $(pwd)/$1

echo "... Starting \".venv\" ($1)"

python -m venv .venv && source ./.venv/bin/activate

echo "... Installing Dependencies"

pip install --upgrade pip
pip install -q $FLAGS

echo "... Creating requirements.txt"

pip freeze -l > requirements.txt

echo "... Creating .gitignore"

cat $HOME/$SRC_FOLDER/gitignore > .gitignore

echo "... Creating .env"

cat $HOME/$SRC_FOLDER/env > .env

echo "... Setup app"

touch app/__init__.py
touch app/main.py
touch app/*/__init__.py
touch tests/__init__.py

#(verificar se o git está instalado)

#se sim:
git init && git add . && git checkout -b main && git commit -m "Initial commit" && git checkout -b developer

#se não:
echo "----------- Setup finished, have a good coding time :) | #happyCoding -----------"
