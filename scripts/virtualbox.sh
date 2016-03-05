#!/usr/bin/env bash

echo "installing virtualbox guest additions"

export DEBIAN_FRONTEND=noninteractive

# install virtualbox additions build dependancies
apt-get --yes install linux-headers-$(uname -r) build-essential dkms


# If libdbus is not installed, virtualbox will not autostart
apt-get -y install --no-install-recommends libdbus-1-3

wget http://download.virtualbox.org/virtualbox/5.0.14/VBoxGuestAdditions_5.0.14.iso

# deprecated: this remove virtualbox additions installed
# from the debian installer pre-wheezy release

#if test -f .vbox_version ; then
  # The netboot installs the VirtualBox support (old) so we have to remove it
#  if test -f /etc/init.d/virtualbox-ose-guest-utils ; then
#    /etc/init.d/virtualbox-ose-guest-utils stop
#  fi

#  rmmod vboxguest
#  aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils
#fi

mkdir /media/VBoxGuestAdditions
mount -o loop,ro VBoxGuestAdditions_5.0.14.iso /media/VBoxGuestAdditions
sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_5.0.14.iso
umount /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions


# Start the newly build driver
service vboxadd start

# cleanup virtualbox stuff
apt-get --yes remove linux-headers-$(uname -r) build-essential dkms
