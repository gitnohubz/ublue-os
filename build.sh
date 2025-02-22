#!/bin/bash

set -ouex pipefail

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

### add custom yum repos :
tee /etc/yum.repos.d/vscode.repo << EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

tee /etc/yum.repos.d/oneAPI.repo << EOF
[oneAPI]
name=Intel® oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF

## for copr repos :
. /etc/os-release

tee /etc/yum.repos.d/sbctl.repo << EOF
[copr:copr.fedorainfracloud.org:chenxiaolong:sbctl]
name=Copr repo for sbctl owned by chenxiaolong
baseurl=https://download.copr.fedorainfracloud.org/results/chenxiaolong/sbctl/fedora-$VERSION_ID-x86_64/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/chenxiaolong/sbctl/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

### groups :
dnf5 -y group install development-tools libreoffice vlc virtualization

### install pkgs : 
dnf5 -y install vdpauinfo \
                libvdpau-va-gl \
                intel-compute-runtime \
                rng-tools \
                krdc \
                usbguard \
                kile \
                ktikz \
                kbibtex \
                kitty \
                kubernetes-client \
                fail2ban \
                fastfetch \
                podlet \
                gdisk \
                code \
                htop \
                torbrowser-launcher \
                qbittorrent \
                koko \
                kamoso \
                syncthing \
                okular \
                gwenview \
                libreoffice-TexMaths \
                tpm2-pkcs11 \
                tpm2-openssl \
                sbctl
                
#                https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
#                https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### resolve confilcts
dnf5 -y install --allowerasing OpenCL-ICD-Loader

### delete pkgs :
dnf5 -y remove amd* \
               nvidia* \
               kde-partitionmanager \
               kate \
               krfb \
               firefox 

#### Systemd Unit Files

systemctl disable lvm2-lvmpolld.socket \
                  cups.socket \
                  iscsid.socket \
                  iscsiuio.socket \
                  raid-check.timer \
                  ModemManager.service \
                  lvm2-monitor.service \
                  fstrim.service \

systemctl enable libvirtd.socket \
                 fwupd-refresh.timer \
                 fail2ban.service \
                 rngd.service
