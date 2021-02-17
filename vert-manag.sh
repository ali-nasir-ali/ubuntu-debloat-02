

Check Compatibility:
$ grep -o 'vmx\|svm' /proc/cpuinfo
Note: if nothing comes back check BIOS to make sure Virtualization. 

1. Run the following Terminal Command:
$ sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin virt-manager
2. Add your user to KVM Groups
$ sudo adduser $USER libvirt
$ sudo adduser $USER libvirt-qemu
