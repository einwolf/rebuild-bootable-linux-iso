# RHEL 7

## Hidden files

There is a .diskinfo and .treeinfo on the iso that need to be included.

## Sample build

```bash
# Testing CentOS-7-x86_64-Minimal-2009.iso

# The iso -V volume label id needs to match the label in the kernal boot args inst.stage2

# isolinux/isolinux.cfg
#######################################
label kickstart
  menu label ^Kickstart Installation of RHEL7.7
  kernel vmlinuz
  append initrd=initrd.img inst.stage2=hd:LABEL=RHEL-7.7\x20Server.x86_64 inst.ks=cdrom:/ks.cfg
#######################################

# EFI/BOOT/grub.cfg
### BEGIN /etc/grub.d/10_linux ###
menuentry 'Install Red Hat Enterprise Linux 7.7' --class fedora --class gnu-linux --class gnu --class os {
    linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=RHEL-7.7\x20Server.x86_64 inst.ks=cdrom:/ks.cfg
    initrdefi /images/pxeboot/initrd.img
}

# mkisofs -o /tmp/rhel7test.iso -b isolinux/isolinux.bin -J -R -l -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -graft-points -V "RHEL-7.7 Server.x86_64" .
# isohybrid --uefi /tmp/rhel7test.iso
# implantisomd5 /tmp/rhel7test.iso
```
