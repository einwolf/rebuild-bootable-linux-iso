#!/bin/bash

BUILD_DIR=rhel-server-7.9-x86_64
BUILD_ISO=rhel-server-7.9-x86_64-boot-test.iso

rm -v "${BUILD_ISO}"

# mkisofs -o "${BUILD_ISO}" -J -R -l -V "RHEL-7.9 Server.x86_64" \
# -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot \
# -b isolinux/isolinux.bin  -c isolinux/boot.cat \
# -e images/efiboot.img -no-emul-boot -graft-points /=CentOS-7-x86_64-Minimal

# Tested with mkisofs via xorriso and genisoimage
# -no-emul-boot is needed after each boot option
# -b -eltorito-boot
# -e -efi-boot
mkisofs -o "${BUILD_ISO}" -v -J -r -T -m TRANS.TBL \
-volid "RHEL-7.9 Server.x86_64" -volset "RHEL-7.9 Server.x86_64" \
-b isolinux/isolinux.bin  -c isolinux/boot.cat \
-no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot \
-e images/efiboot.img -no-emul-boot -graft-points /="${BUILD_DIR}"

# Apparently this allows usb booting
isohybrid --uefi "${BUILD_ISO}"

# Add checksum for test this disk boot option
implantisomd5 "${BUILD_ISO}"
