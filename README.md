[![Build_Image](https://github.com/YardQuit/imparo/actions/workflows/build.yml/badge.svg)](https://github.com/YardQuit/imparo/actions/workflows/build.yml)
[![Clean_Images](https://github.com/YardQuit/imparo/actions/workflows/cleanup.yml/badge.svg)](https://github.com/YardQuit/imparo/actions/workflows/cleanup.yml)
[![Build ISOs](https://github.com/YardQuit/imparo/actions/workflows/build-iso.yml/badge.svg)](https://github.com/YardQuit/imparo/actions/workflows/build-iso.yml)
[![Dependabot Updates](https://github.com/YardQuit/imparo/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/YardQuit/imparo/actions/workflows/dependabot/dependabot-updates)

# imparo

## Purpose

Testing COSMIC DE atomic, built on fedora-bootc base-image

## Install
### rpm-ostree rebase
Rebase from rpm-ostree:
```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/yardquit/imparo:latest
```
Restart your system for the changes take effect:
```bash
systemctl reboot
```

### bootc switch
Rebase from bootc
```bash
sudo bootc switch ghcr.io/yardquit/imparo:latest
```

Restart your system for the changes take effect:
```bash
systemctl reboot
```
