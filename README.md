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

`$	./brewer -h archive`

`$	./brewer -h install`

Enhancements
===
- [Homebrew Cask](https://github.com/caskroom/homebrew-cask) support
<!-- http://lifehacker.com/how-to-make-your-own-bulk-app-installer-for-os-x-1586252163 -->

Contributors
===
- [Craig Buchanan](https://github.com/craibuc)

Pull requests welcomed.