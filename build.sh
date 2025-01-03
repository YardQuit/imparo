#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### COPY FILES
cp -rv /tmp/sysfiles/* /

### INSTALL PACKAGES
dnf -y install \
$(cat /tmp/packages/desktop) \
$(cat /tmp/packages/personal) 

### Run configuration scripts
sh /tmp/scripts/script_template.sh

### Disabling System Unit File(s)

### Enabling System Unit File(s)
systemctl enable cosmic-greeter.service
systemctl enable bootc-fetch-apply-updates.timer
systemctl enable tuned.service
systemctl enable podman.socket
systemctl enable fstrim.timer
# systemctl enable firewalld.service

### Change default firewalld zone
# cp /etc/firewalld/firewalld-workstation.conf /etc/firewalld/firewalld-workstation.conf.bak
# sed -i 's/DefaultZone=FedoraWorkstation/DefaultZone=drop/g' /etc/firewalld/firewalld-workstation.conf

### Clean Up
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
rm -rf /etc/yum.repos.d/_copr_ryanabx-cosmic.repo
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:a-zhn:ghostty.repo
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:pennbauman:ports.repo
rm -rf /etc/yum.repos.d/atim-starship-fedora-41.repo
