Brewer
==

Bash shell script to archive or restore a workstation's Homebrew formulas.

Installation
===

 - Download ZIP (or just brewer.sh)
 - Move `brewer.sh` to desired folder
 - Make script executable:

`$ chmod +x brewer.sh`

- Create symlink:

`$ ln -s brewer.sh brewer`

Usage
===

Create archive of current formulas:

`$	./brewer archive`

Install formulas (after an OS reinstall, for example):

`$	./brewer install`

Get help:

`$	./brewer help`
