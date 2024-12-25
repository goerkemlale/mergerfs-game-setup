#!/bin/bash

# 1.Path to your base directory (if running this script outside)
DIR_BASE="./"

# 2. Final directory, where you can see overview
DIR_MERGED="$DIR_BASE/merged"

# 3. Game directory
DIR_GAME="$DIR_BASE/game"

# 4. Mods directory
DIR_MODS="$DIR_BASE/mods"

#Scan all mod directories in mods directory
MERGERFS_DIRS=$(find $DIR_MODS -mindepth 1 -maxdepth 1 -type d | sort | tr '\n' ':' | sed 's/:$//')
#Combine all merged files with : operator
MERGERFS_DIRS="$MERGERFS_DIRS:$DIR_GAME"

mergerfs -o allow_other "$MERGERFS_DIRS" "$DIR_MERGED"

# If want permanent, do fstab
#FSTAB_FILE="/etc/fstab"
#FSTAB_ENTRY="mergerfs $MERGERFS_DIRS $DIR_MERGED fuse.defaults,allow_other,cache.files=off 0 0" grep -qxF "$FSTAB_ENTRY" $FSTAB_FILE || echo $FSTAB_ENTRY | sudo tee -a $FSTAB_FILE

echo "To unmount 'sudo umount $DIR_MERGED'"
