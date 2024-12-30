#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### COPY FILES
cp -rv /tmp/sysfiles/* /

### INSTALL PACKAGES
dnf -y install \
$(cat /tmp/packages/desktop) 

### Run configuration scripts
sh /tmp/scripts/script_template.sh

### Disabling System Unit File(s)

### Enabling System Unit File(s)
systemctl enable cosmic-greeter.service
systemctl enable rpm-ostreed-automatic.timer
systemctl enable tuned.service
systemctl enable podman.socket
systemctl enable fstrim.timer
systemctl enable firewalld.service

### Change default firewalld zone
# cp /etc/firewalld/firewalld-workstation.conf /etc/firewalld/firewalld-workstation.conf.bak
# sed -i 's/DefaultZone=FedoraWorkstation/DefaultZone=drop/g' /etc/firewalld/firewalld-workstation.conf

### Clean Up
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
rm -rf /etc/yum.repos.d/_copr_ryanabx-cosmic.repo
