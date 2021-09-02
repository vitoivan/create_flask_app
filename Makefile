SRC = .setup_flask_project
F_DIR = files

all: src move alias finished

src:
	@echo "Creating directory $(SRC) ..."
	@mkdir -p $(HOME)/$(SRC);
	@echo "Directory created in $(HOME)/$(SRC)"
move: $(F_DIR)
	@echo "Moving files to $(SRC)..."
	@cp -r ./$(F_DIR)/* $(HOME)/$(SRC)
	@echo "Done!"

alias:
	@echo "Creating alias ..."
	@bash ./alias.sh
	@echo "Done!"

finished:
	@echo "Installation finished"
