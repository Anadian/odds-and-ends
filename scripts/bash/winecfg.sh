#!/usr/bin/bash

# Prerequisites
if [[ -z ${STEAM_PATH+1} ]]; then
	STEAM_PATH="$HOME/snap/steam/common/.local/share/Steam";
fi
echo "STEAM_PATH: $STEAM_PATH";

# Input Arguments
STEAM_APP_ID=${1:?'Error: need to pass a Steam app ID as an argument'};
echo "STEAM_APP_ID: $STEAM_APP_ID";

PROTON_TYPE=${2:-'Proton Hotfix'};
echo "PROTON_TYPE: $PROTON_TYPE";

PROTON_SUBCOMMAND=${3:-'runinprefix'};
echo "PROTON_SUBCOMMAND: $PROTON_SUBCOMMAND";

TARGET_WINE_APP=${4:-'winecfg'};
echo "TARGET_WINE_APP: $TARGET_WINE_APP";

# Derived Variables

if [[ -z ${STEAM_COMPAT_DATA_PATH+1} ]]; then
	STEAM_COMPAT_DATA_PATH="$STEAM_PATH/steamapps/compatdata/$STEAM_APP_ID"; 
fi
echo "STEAM_COMPAT_DATA_PATH: $STEAM_COMPAT_DATA_PATH";

if [[ -z ${WINEPREFIX+1} ]]; then
	WINEPREFIX="$STEAM_COMPAT_DATA_PATH/pfx";
fi
echo "WINEPREFIX: $WINEPREFIX";

if [[ -z ${PROTON_PATH+1} ]]; then
	PROTON_PATH="$STEAM_PATH/steamapps/common/$PROTON_TYPE";
fi
echo "PROTON_PATH: $PROTON_PATH";

if [[ -z ${WINEPATH+1} ]]; then
	WINEPATH="$PROTON_PATH/files/bin/wine64";
fi
echo "WINEPATH: $WINEPATH";

if [[ -z ${PROTON_EXECUTABLE+1} ]]; then
	PROTON_EXECUTABLE="$PROTON_PATH/proton";
fi
echo "PROTON_EXECUTABLE: $PROTON_EXECUTABLE";

# Final Command

echo "$PROTON_EXECUTABLE $PROTON_SUBCOMMAND $TARGET_WINE_APP";
STEAM_COMPAT_DATA_PATH="$STEAM_COMPAT_DATA_PATH" "$PROTON_EXECUTABLE" "$PROTON_SUBCOMMAND" "$TARGET_WINE_APP";
# Original command: WINEPREFIX="/home/cameron/snap/steam/common/.local/share/Steam/steamapps/compatdata/391580/pfx/" WINEPATH="/home/cameron/snap/steam/common/.local/share/Steam/steamapps/common/Proton Hotfix/files/bin/wine64" STEAM_COMPAT_DATA_PATH="/home/cameron/snap/steam/common/.local/share/Steam/steamapps/compatdata/391580/" "/home/cameron/snap/steam/common/.local/share/Steam/steamapps/common/Proton Hotfix/proton" runinprefix winecfg
