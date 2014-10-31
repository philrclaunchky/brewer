#!/bin/sh

# Usage:
#
#	brewer command [options]
#
# Exmaples:
#
#	brewer archive
#	brewer install
#	brewer help
#
# Options:
#
#	-V		Set the verbose level of output

function archive() {

	# if verbose flag
	echo "Archiving current list of Homebrew formulas..."
	brew list >> ~/sh.brew.formulas.txt
		
}

function install() {
	
	# TODO: if ~/sh.brew.formulas.txt doesn't exist, fail
	
	# 
	echo "Installing Homebrew..."
	# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# get most-recent list of formulas
	echo "Updating Homebrew..."
	brew update

	# TODO: disable macports
	echo "Disabling Macports..."

	# process list of formulas that have been installed
	echo "Installing formulas..."
	for i in $(cat ~/sh.brew.formulas.txt) ; do
		echo $i
	#  brew install $i
	done
		
}

help() {

	# TODO: finish help documentation
	echo "Valid arguments: archive, install, help"
	echo "$ ./brewer.sh $1"

}

# TODO: validate parameters
case $1 in
	
	"archive") archive
        break ;;

	"install") install
		break ;;

	"help") help
		break;;

	*) echo "Invalid entry: " $1
		help
		break ;;

esac
