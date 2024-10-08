#!/usr/bin/env sh
#
ACTIVEWS=$(hyprctl -j monitors | jq ".[0].activeWorkspace.id")
export a"$ACTIVEWS"="active"

function handle_event {
	case ${1%>>*} in
		workspace)
			unset a"$ACTIVEWS"
			ACTIVEWS=${1#*>>}
			export a"$ACTIVEWS"="active"
			create_taglist
			;;
		focusedmon)
			ACTIVEWS=${1#*,}
			;;
		createworkspace)
			local WORKSPACE=${1#*>>}
			export o"$WORKSPACE"="occupied"
			create_taglist
			;;
		destroyworkspace)
			local WORKSPACE=${1#*>>}
			unset o"$WORKSPACE"
			create_taglist
	esac
}

function create_taglist {
	echo "[\"$o1 $a1\", \"$o2 $a2\", \"$o3 $a3\", \"$o4 $a4\", \"$o5 $a5\", \"$o6 $a6\", \"$o7 $a7\"]"
}

for NUM in {0..8}; do
	WORKSPACE=$(hyprctl -j workspaces | jq ".[$NUM].id")
	if [[ $WORKSPACE != "null" ]]; then
	export o"$WORKSPACE"="occupied"
	fi
done

create_taglist

socat -u "UNIX-CONNECT:/run/user/${UID}/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do handle_event "$line"; done
