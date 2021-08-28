SRC = .setup_python_project
FILES = gitignore env run.sh
DEFSHELL = .bashrc

all: src move alias

src:
	@echo "Creating directory $(SRC) ..."
	@mkdir -p $(HOME)/$(SRC);
	@echo "Directory created in $(HOME)/$(SRC)"
move:
	@echo "Moving files to $(SRC)..."
	@cp $(FILES) $(HOME)/$(SRC)
	@echo "Done!"

alias:
	@echo "\n++++++++ For create an alias, put this code on your \"~/.zshrc\", \"~/.bashrc\" or \"~/.bash_aliases\" ++++++++++"
	@echo "alias createpy='$(HOME)/$(SRC)/run.sh'"
