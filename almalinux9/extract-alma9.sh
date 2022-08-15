#!/bin/bash

EXTRACT_ISO=AlmaLinux-9.0-x86_64-minimal.iso
EXTRACT_DIR=AlmaLinux-9.0-x86_64-minimal

rm -rfv "${EXTRACT_DIR}"
mkdir "${EXTRACT_DIR}"

# Accurate permissions are not required because iso9660 doesn't support it.
# Rock ridge is not useful on boot media.

# file-roller needs x11
# file-roller --extract-to=FOLDER

# iso-info is in some versions of cdrtookit
# isoinfo -R -X

# xorriso iso to disk
xorriso -osirrox on -indev "${EXTRACT_ISO}" -extract / "${EXTRACT_DIR}"

# 7z or 7za saves boot images in [BOOT]
#7za x "${EXTRACT_ISO}" -o "${EXTRACT_DIR}"

# Loop
# rsync is used to make sure .diskinfo and .treeinfo are copied
# mkdir -p /mnt/iso
# mount -o loop,ro "${EXTRACT_ISO}" /mnt/iso

# rsync -rvt --stats --delete --progress /mnt/iso/ "${EXTRACT_DIR}/"

# umount /mnt/iso
