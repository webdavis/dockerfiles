#!/usr/bin/env sh

pinit()
{
	local process
	process=`pgrep pcscd`
	if [ -z "$process" ]; then
		echo 'starting pcscd in backgroud'
		pcscd --debug --apdu
		pcscd --hotplug
	else
		echo "pcscd is running in already: ${process}"
	fi
}

pinit

"$@"
