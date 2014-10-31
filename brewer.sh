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

FILE=~/sh.brew.formulas.txt

function archive() {

	# if verbose flag
	echo "Archiving current list of Homebrew formulas..."
	brew list >> ~/sh.brew.formulas.txt
		
}

function install() {
	
	# if ~/sh.brew.formulas.txt doesn't exist, fail
	if [ ! -f $FILE ];
	then
	   echo "$FILE does not exist.  Please run './brewer archive' to create it."
	   return
	fi
	
	# if Homebrew not installed, install it
	type -P brew &>/dev/null && echo "Homebrew found." || {
		echo "Installing Homebrew..."
		# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	}

	# get most-recent list of formulas
	echo "Updating Homebrew..."
	brew update

	# TODO: disable macports
	echo "Disabling Macports..."

	# process list of formulas that have been installed
	echo "Installing formulas..."
	for i in $(cat ~/sh.brew.formulas.txt) ; do
		echo $i
		
		# attempt to install formula
		#  brew install $i

		#TODO: if error (e.g. alread installed), write error, process next formula

	done

	echo "Processing completed."
}

help() {

	# TODO: finish help documentation
	echo "Valid arguments: archive, install, help"
	echo "$ ./brewer.sh $1"

}

# TODO: parse and validate parameters ($1 ,$2)

# TODO: validate commands
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

# TODO: capture/validate options