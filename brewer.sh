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

# TODO: parse and validate parameters ($1 ,$2)
# TODO: capture/validate options
# TODO: implement -V logic

FILE=~/sh.brew.formulas.txt

#
# Save list of install Homebrew formulas to a file.
#
function archive() {

	echo "Archiving current list of Homebrew formulas ..."

	brew list >> $FILE

	echo "$FILE created."

}

#
# Install Homebrew, then install formulas.
#
function install() {
	
	# if $FILE doesn't exist, fail
	if [ ! -f $FILE ];
	then
	   echo "$FILE does not exist.  Please run './brewer archive' to create it."
	   return
	fi
	
	# if Homebrew not installed, install it
	type -P brew &>/dev/null && echo "Homebrew found ..." || {

		echo "Installing Homebrew ..."
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	}

	# get most-recent list of formulas
	echo "Updating Homebrew ..."
	brew update

	# TODO: disable macports
	echo "Disabling Macports ..."

	echo "Installing formulas..."

	# process list of formulas that have been installed
	# ignoring lines that start with an '#'
	for i in $( sed '/^#/ d' < "$FILE") ; do

		echo "Installing $i ..."

		# attempt to install formula
		# if error (e.g. alread installed), write error, process next formula
		brew install $i || continue

	done

	echo "Processing completed."
}

#
# Display help text.
#
help() {

cat << EOF

Usage:

  brewer command [options]

Exmaples:

  brewer archive
  brewer install
  brewer help

Options:

  -V     Enable verbose output

EOF

}

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