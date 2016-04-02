#!/bin/bash

# Download the original .pdb-files for the 102 targets of the DUD-E
# This script assumes that in the working directory the directory 'all' exists.
# 'all' contains all the ligands, decoys, and structures for the whole DUD-E

wget=/usr/bin/wget
gunzip=/bin/gunzip

 Check whether wget und gunzip is available
if [ ! -x "$wget" ]; then
	echo "ERROR: No wget." >&2
  	exit 1
elif [ ! -x "$gunzip" ]; then
	echo "ERROR: No gunzip" >&2
	exit 1
fi

# array of targets
declare -a targets=(	"aa2ar" "abl1" "ace" "aces" "ada" "ada17" "adrb1" "adrb2" "akt1" "akt2"
			"aldr" "ampc" "andr" "aofb" "bace1" "braf" "cah2" "casp3" "cdk2" "comt"
			"cp2c9" "cp3a4" "csf1r" "cxcr4" "def" "dhi1" "dpp4" "drd3" "dyr" "egfr"
			"esr1" "esr2" "fa10" "fa7" "fabp4" "fak1" "fgfr1" "fkb1a" "fnta" "fpps"
			"gcr" "glcm" "gria2" "grik1" "hdac2" "hdac8" "hivint" "hivpr" "hivrt" "hmdh"
			"hs90a" "hxk4" "igf1r" "inha" "ital" "jak2" "kif11" "kit" "kith" "kpcb"
			"lck" "lkha4" "mapk2" "mcr" "met" "mk01" "mk10" "mk14" "mmp13" "mp2k1"
			"nos1" "nram" "pa2ga" "parp1" "pde5a" "pgh1" "pgh2" "plk1" "pnph" "ppara"
			"ppard" "pparg" "prgr" "ptn1" "pur2" "pygm" "pyrd" "reni" "rock1" "rxra"
			"sahh" "src" "tgfr1" "thb" "thrb" "try1" "tryb1" "tysy" "urok" "vgfr2"
			"wee1" "xiap")

# Array of PDB ids
declare -a pdb_ids=(	"3eml" "2hzi" "3bkl" "1e66" "2e1w" "2oi0" "2vt4" "3ny8" "3cqw" "3d0e"
			"2hv5" "1l2s" "2am9" "1s3b" "3l5d" "3d4q" "1bcd" "2cnk" "1h00" "3bwm"
			"1r9o" "3nxu" "3krj" "3odu" "1lru" "3frj" "2i78" "3pbl" "3nxo" "2rgp"
			"1sj0" "2fsz" "3kl6" "1w7x" "2nnq" "3bz3" "3c4f" "1j4h" "3e37" "1zw5"
			"3bqd" "2v3f" "3kgc" "1vso" "3max" "3f07" "3nf7" "1xl2" "3lan" "3ccw"
			"1uyg" "3f9m" "2oj9" "2h7l" "2ica" "3lpb" "3cjo" "3g0e" "2b8t" "2i0e"
			"2of2" "3chp" "3m2w" "2aa2" "3lq8" "2ojg" "2zdt" "2qd9" "830c" "3eqh"
			"1qw6" "1b9v" "1kvo" "3l3m" "1udt" "2oyu" "3ln1" "2owb" "3bgs" "2p54"
			"2znp" "2gtk" "3kba" "2azr" "1njs" "1c8k" "1d3g" "3g6z" "2etr" "1mv9"
			"1li4" "3el8" "3hmm" "1q4x" "1ype" "2ayw" "2zec" "1syn" "1sqt" "2p2i"
			"3biz" "3hl5")

# Make sure that a directory called 'all' is in the current working directory and that for each
# target a valid directory exists.
if [ ! -d "all" ]; then
	echo "directory 'all' does not exist"
	exit
fi

# Loop over the targets and check if the corresponding directory ./all/[target] exists 
for ((i=1; i<=102; i++))
do
	if [ ! -d "all/${targets[$i]}" ]; then
		echo "directory 'all/${targets[$i]}' does not exist"
		exit
	fi
done

# Loop over the targets and download the corresponding pdb file.
for ((i=0; i<=101; i++))
do
	# Change into the directory
	cd all/${targets[$i]}
	# Download the structure
	wget ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/pdb/pdb${pdb_ids[$i]}.ent.gz
	# unpack the structure
	gunzip pdb${pdb_ids[$i]}.ent.gz
	# rename the .pdb file
	mv pdb${pdb_ids[$i]}.ent receptor_originalPDB.pdb
	# Return to the base directory
	cd ../..
done
