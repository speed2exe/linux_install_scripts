#!/bin/sh

sudo pacman -Syu qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat \
    ebtables iptables \
    libguestfs

sudo groupadd libvirt
sudo usermod -a -G libvirt $USER
sudo systemctl enable --now libvirtd.service
