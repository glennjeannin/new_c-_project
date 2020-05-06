# Système d'exploitation
OS_NAME=$(shell uname -s)

# Nommage et paramétrage du compilateur
CC=g++
CFLAGS=-W -Wall -pedantic
LDFLAGS=-lm

# Chemin vers l'application (build)
BUILD_PATH=build/$(OS_NAME)

# Nom de l'exécutable
EXEC=test

# Règle par défaut
.DEFAULT_GOAL := all

# ------------------------------------ Liste des cibles ------------------------------------

# Création du répertoire de build
$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

# Efface les fichiers temporaires et les fichiers finaux
clean:
	rm -rf $(BUILD_PATH)

# Compilation de 'lib/fonctions.cxx'
$(BUILD_PATH)/fonctions.o: lib/fonctions.cxx | $(BUILD_PATH)
	$(CC) $(CFLAGS) -c lib/fonctions.cxx -I ./lib -o $(BUILD_PATH)/fonctions.o

# Compilation de 'src/main.cxx'
$(BUILD_PATH)/main.o: src/main.cxx lib/fonctions.h | $(BUILD_PATH)
	$(CC) $(CFLAGS) -c src/main.cxx -I ./lib -o $(BUILD_PATH)/main.o

# Edition de liens
$(BUILD_PATH)/$(EXEC): $(BUILD_PATH)/fonctions.o $(BUILD_PATH)/main.o | $(BUILD_PATH)
	$(CC) $(LDFLAGS)  $(BUILD_PATH)/fonctions.o $(BUILD_PATH)/main.o -o $(BUILD_PATH)/$(EXEC)

# Compile et assemble l'application
all: $(BUILD_PATH)/$(EXEC)
