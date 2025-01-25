#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### COPY FILES
cp -rv /tmp/sysfiles/* /

# Installs package(s)
# dnf5 -y copr enable ublue-os/akmods

dnf5 -y install \
$(cat /tmp/packages/desktop_std) \
$(cat /tmp/packages/security) \
$(cat /tmp/packages/fonts) \
$(cat /tmp/packages/personal) 

# Installs package(s) from copr repos
dnf5 -y copr enable a-zhn/ghostty
dnf5 -y install ghostty
dnf5 -y copr disable a-zhn/ghostty

dnf5 -y copr enable atim/starship
dnf5 -y install starship
dnf5 -y copr disable atim/starship

dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install $(cat /tmp/packages/desktop_env)
dnf5 -y copr disable ryanabx/cosmic-epoch

### Run configuration scripts
sh /tmp/scripts/script_template.sh

### Disabling System Unit File(s)

### Enabling System Unit File(s)
systemctl enable bootc-fetch-apply-updates.timer
systemctl enable cosmic-greeter.service
systemctl enable tuned.service
systemctl enable podman.socket
systemctl enable fstrim.timer
systemctl enable firewalld.service

### Change default firewalld zone
cp /etc/firewalld/firewalld-workstation.conf /etc/firewalld/firewalld-workstation.conf.bak
sed -i 's/DefaultZone=FedoraWorkstation/DefaultZone=drop/g' /etc/firewalld/firewalld-workstation.conf

### Fix bug preventing systemd-remount-fs.service to start - Does not work
# sed -i 's/subvol\[=.*\]/#&/g' /etc/fstab

### Clean Up
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
