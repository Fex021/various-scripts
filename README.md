# various-scripts

This is a collection of various scripts (Python, Bash, etc.).

#dud-e_original_target_structures.sh
DUD-E is a database used to evaluate the performance for protein-ligand docking.One can download the whole database from http://dude.docking.org/.
This script downloads all original pdb-files from http://www.rcsb.org.
To do so, download at first the whole DUD-E database and extract the archive file. Now a directory 'all' containing subdirectories for each target should exist.
Call the script from the directory the same directory where 'all' lives and the original pdb-file is downloaded into the corresponding target subdirectory.
The original pdb-files are called 'receptor_originalPDB.pdb'
