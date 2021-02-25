#!/bin/bash

# Debian Setup Script

dpkg -l | grep -qw gdebi || sudo apt-get install -yyq gdebi

# Initial Software

sudo apt update

sudo apt install virtualbox virtualbox-guest-additions-iso virtualbox-ext-pack \
net-tools htop grsync lame asunder soundconverter brasero git mc shutter \
openssh-server sshfs gedit-plugin-text-size obs kdenlive nano mpv vlc \
remmina qt5-style-plugins spell synaptic okular audacity terminator -yy

# Add me to any groups I might need to be a part of:

sudo adduser $USER vboxusers

# Purge Firefox, install Google Chrome:

sudo apt purge firefox -yy
sudo apt purge firefox-locale-en -yy
if [ -d "/home/$USER/.mozilla" ]; then
    rm -rf /home/$USER/.mozilla
fi
if [ -d "/home/$USER/.cache/mozilla" ]; then
    rm -rf /home/$USER/.cache/mozilla
fi
mkdir /tmp/gc-install-tmp
pushd /tmp/gc-install-tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable_current_amd64.deb
popd
rm -rf /tmp/gc-install-tmp

## Multimedia
sudo apt-get install -y gimp audacious nautilus-dropbox

## Games
sudo apt-get install -y steam lutris

# Gotta reboot now:
sudo apt update && sudo apt upgrade -y

echo $'\n'$"*** All done! Please reboot now. ***"
