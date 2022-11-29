# ----------------------------------------------------------------------------------------------------
# Description:
# This Makefile will build a library from object files (.o) in the obj directory, and this library 
# (libadd.a) will be placed in the 'lib' directory. The Makefile will also build an executable file 
# ('run'), which will be placed in the bin directory. 
# 
# Running the Program:
# To run program, type 'make' into the command on the level that "Makefile" is contained in.
# Enter the bin directory and type './run' in the command line to run the program.
#
# Cleaning Up:
# Typing 'make clean' into the command on the level that "Makefile" is contained in will delete all
# output (.o) files in OBJ, library (.a) in LIB, and the executable (run) in BIN directories
# 
# NOTE: In the case of Fortran, a module file (.mod) will be created during the creation of output 
# (.o) files, since we have one module acting as an auxillary. This module file must be placed in SRC 
# for the executable file (run) to compile. This is done using the -J<directory> flag for Fortran 90. 
# Typing 'make clean' will also delete the .mod file.  
# ----------------------------------------------------------------------------------------------------

# Directory Variables
SRC_DIR=src
OBJ_DIR=obj
LIB_DIR=lib
BIN_DIR=bin
MOD_DIR=mod

# Configuration Settings
FC=gfortran
FFLAGS=-O2 -Wall -Wextra
AR=ar rcs

# Library and Binary Names
LIBNAME=MGD2_lib
BINNAME=run_1D

# The main file
MAIN=main.f90

# "List" of all obj files
OBJ_LIST=constants.f90 bounds.f90 repeated_routines.f90 Maxwell_1D.f90 m_diag.f90 lambda_diag.f90 psi.f90 es_bgk_1D.f90 density.f90 xvelocity.f90 yvelocity.f90 zvelocity.f90 temp.f90 visc_str_xx.f90 visc_str_xy.f90 heat_flux_x.f90 krookcoll_1D.f90 krookcoll_1D_hs.f90 convect.f90
SRC=$(addprefix $(OBJ_DIR)/, $(OBJ_LIST))
OBJ=$(patsubst $(OBJ_DIR)/%.f90, $(OBJ_DIR)/%.o, $(SRC))
LIB=$(patsubst %, $(LIB_DIR)/lib%.a, $(LIBNAME))
BIN=$(patsubst %, $(BIN_DIR)/%, $(BINNAME))

# Build the Targets
build: $(OBJ) $(LIB) $(BIN)

# Create the executable file from the source and put in binaries
$(BIN): $(LIB)
	$(FC) $(FFLAGS) -o $@ $(SRC_DIR)/$(MAIN) $(LIB)

# Create the static library from obj files
$(LIB): $(OBJ)
	$(AR) $@ $^

# Create .o files from objects/auxillary files (Subroutines, Modules)
$(OBJ_DIR)/%.o: $(OBJ_DIR)/%.f90
	$(FC) $(FFLAGS) -J$(SRC_DIR) -o $@ -c $<

# Remove object files, mod files, libraries, and executables
clean:
	rm -f $(OBJ_DIR)/*.o $(SRC_DIR)/*.mod $(LIB_DIR)/*.a $(BIN_DIR)/run*
