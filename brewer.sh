#!/bin/sh

# Author:	Craig Buchanan

# Purpose:	Archive currently installed Homebrew formulas to allow them to be reinstalled after a OS failure

# Revision History:
	# 31-OCT-2014 - created
	# 07-NOV-2014 - command-line parameter support

# Enhancements:
# * Homebrew Cask support?

# Reset POSIX variable in case getopts has been used previously in the shell.
OPTIND=1

# Initialize variables:
FORMULAS=~/sh.brew.formulas.txt
verbose=0
show_help=0

#
# heredocs
#
GENERAL_HELP=$(cat << 'EOF'

Usage:

  brewer [options] command

Exmaples:

  brewer archive
  brewer install

Options:

  -h     Display help
  -v     Enable verbose output

EOF)

ARCHIVE_HELP=$(cat << 'EOF'

Usage:

  brewer [options] archive

Exmaples:

  brewer archive
  brewer -f PATH/TO/FILE archive

Options:

  -f     file to use as destination (default: $FORMULAS)


EOF)

INSTALL_HELP=$(cat << 'EOF'

Usage:

  brewer [options] install

Exmaples:

  brewer install
  brewer -f PATH/TO/FILE install

Options:

  -f     file to use as source (default: $FORMULAS)

EOF)

#
# Save list of install Homebrew formulas to a file.
#
function archive() {

    if [ $show_help -eq 1 ]; 
    then
        echo "$ARCHIVE_HELP\n"
        exit 1
    fi

    if [ $verbose -eq 1 ]; 
    then	
		echo "Archiving current list of Homebrew formulas ..."
	fi
	
	# make back-up current file if it exists
	if [ -f $FORMULAS ]; then
		
	    if [ $verbose -eq 1 ]; 
	    then
			echo "Copying existing archive to $(basename $FORMULAS .txt)_$(stat -f "%Sm" -t "%Y%m%dT%H%M%S").txt ..."
		fi
		mv "$FORMULAS" "$(basename $FORMULAS .txt)_$(stat -f "%Sm" -t "%Y%m%dT%H%M%S").txt"
	fi

	# redirect command to a file
	brew list >> $FORMULAS

    if [ $verbose -eq 1 ]; 
    then
		echo "$FORMULAS created."
	fi

}

#
# Install Homebrew, then install formulas.
#
function install() {

    if [ $show_help -eq 1 ]; 
    then
        echo "$INSTALL_HELP\n"
        exit 1
    fi
		
	# if $FILE doesn't exist, fail
	if [ ! -f $FORMULAS ];
	then
	    if [ $verbose -eq 1 ]; 
	    then
	   		echo "$FORMULAS does not exist.  Please run './brewer archive' to create it."
		fi
	   exit 2
	fi
	
	# if Homebrew not installed, install it
	type -P brew &>/dev/null && echo "Homebrew found ..." || {

		echo "Installing Homebrew ..."
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	}

	# get most-recent list of formulas
    if [ $verbose -eq 1 ]; 
    then
		echo "Updating Homebrew ..."
	fi
	brew update

	# TODO: disable macports
    if [ $verbose -eq 1 ]; 
    then
		echo "Disabling Macports ..."
	fi
	
    if [ $verbose -eq 1 ]; 
    then
		echo "Installing formulas..."
	fi
	
	# process list of formulas that have been installed
	# ignoring lines that start with an '#'
	for i in $( sed '/^#/ d' < "$FORMULAS") ; do

	    if [ $verbose -eq 1 ]; 
	    then
			echo "Installing $i ..."
		fi
		
		# attempt to install formula
		# if error (e.g. alread installed), write error, process next formula
		brew install $i || continue

	done

    if [ $verbose -eq 1 ]; 
    then
		echo "Processing completed."
	fi
}

#
# Process command line
#
while getopts "h?vf:" opt; do

    case "$opt" in
    h|\?)
        show_help=1
        ;;
    v)  verbose=1
        ;;
    f)  FILE=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

# echo "verbose=$verbose, show_help=$show_help, FILE='$FILE', Leftovers: $@"

if [ $# -eq 0 ]
  then
    echo "$GENERAL_HELP\n"
	exit 1
fi

# run command
$1
