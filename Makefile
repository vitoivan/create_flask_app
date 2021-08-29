SRC = .setup_python_project
FILES = gitignore env run.sh initapp

all: src move alias finished

src:
	@echo "Creating directory $(SRC) ..."
	@mkdir -p $(HOME)/$(SRC);
	@echo "Directory created in $(HOME)/$(SRC)"
move:
	@echo "Moving files to $(SRC)..."
	@cp $(FILES) $(HOME)/$(SRC)
	@echo "Done!"

alias:
	@echo "Creating alias ..."
	@bash ./alias.sh
	@echo "Done!"

finished:
	@echo "Installation finished"
