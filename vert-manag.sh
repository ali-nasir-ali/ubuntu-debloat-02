for wifi:
it will restart the driver:
/etc/init.d/network-manager restart

to see what hardwear wifi on the machine:
lspci -knn | grep Net -A2
lspci | grep -i wireless


solotion :
-----------------------
main website for solutions:
https://wiki.libvirt.org/page/Networking




solotion :
-----------------------
Check Compatibility:
$ grep -o 'vmx\|svm' /proc/cpuinfo
Note: if nothing comes back check BIOS to make sure Virtualization. 

1. Run the following Terminal Command:
$ sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin virt-manager
2. Add your user to KVM Groups
$ sudo adduser $USER libvirt
$ sudo adduser $USER libvirt-qemu


solotion :
-----------------------
best solution:
https://wiki.debian.org/KVM



solotion :
-----------------------
found at :
https://www.linuxquestions.org/questions/linux-virtualization-and-cloud-90/virsh-failed-to-start-network-default-4175672429/

virsh net-undefine default
virsh net-destroy default
virsh net-list
systemctl enable --now libvirtd
systemctl enable virtlogd.socket
systemctl restart libvirtd.service
cat default.xml
virsh net-define default.xml
virsh net-autostart default
virsh net-start default


solotion :
-----------------------
inside my default.xml file :

 naser  rorschach  ../libvirt/qemu/networks  sudo cat default.xml 

<!--
WARNING: THIS IS AN AUTO-GENERATED FILE. CHANGES TO IT ARE LIKELY TO BE
OVERWRITTEN AND LOST. Changes to this xml configuration should be made using:
  virsh net-edit default
or other application using the libvirt API.
-->

<network>
  <name>default</name>
  <uuid>b8eb013f-6146-4e10-86cd-495003d68ad5</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:62:7b:b8'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>







solotion :
-----------------------

found on github:
https://gist.githubusercontent.com/archerslaw/9523b3857a2553a4f84a/raw/b901cb605eb38906cb4cbc7bde4bbd341c2761a0/solve%2520the%2520%2522no%2520network%2520with%2520matching%2520name%2520'default'%2522%2520problem.


# virsh create rhel7.xml 
error: Failed to create domain from rhel7.xml
error: Network not found: no network with matching name 'default'

# virsh net-list --all
 Name                 State      Autostart     Persistent
----------------------------------------------------------
 default              active     no            yes

# virsh net-define /dev/stdin <<EOF
> <network connections='1'>
>   <name>default</name>
>   <uuid>18bb3790-11ee-41b1-8847-970590a06e4d</uuid>
>   <forward mode='nat'/>
>   <bridge name='virbr0' stp='on' delay='0' />
>   <mac address='52:54:00:F6:C8:DE'/>
>   <ip address='192.168.122.1' netmask='255.255.255.0'>
>     <dhcp>
>       <range start='192.168.122.2' end='192.168.122.254' />
>     </dhcp>
>   </ip>
> </network>
> EOF
Network default defined from /dev/stdin

# virsh net-start default
Network default started

# virsh net-list --all
 Name                 State      Autostart     Persistent
----------------------------------------------------------
 default              active     no            yes

# virsh create rhel7.xml 
Domain rhel7 created from rhel7.xml

# virsh list
 Id    Name                           State
----------------------------------------------------
 15    rhel7                          running

##############################################################
# ifconfig virbr0 down
# virsh net-start default
error: Failed to start network default
error: Unable to create bridge virbr0: File exists

# ifconfig virbr0 up
# virsh net-start default
error: Failed to start network default
error: internal error: Network is already in use by interface virbr0

# ifconfig virbr0 down
# brctl delbr virbr0
# virsh net-autostart default
Network default marked as autostarted
# virsh net-start default
Network default started

