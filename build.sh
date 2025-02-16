#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf install -y 

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

tee > /etc/yum.repos.d/oneAPI.repo << EOF
[oneAPI]
name=Intel® oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF
### delete pkgs :
dnf5 -y remove amd* \
              nvidia* \
              kde-partitionmanager \
              kate \
              krfb
### install pkgs : 
dnf5 -y install @virtualization \
                vdpauinfo \
                intel-compute-runtime \
                rng-tools \
                krdc \
                usbguard-notifier \
                kile \
                ktikz \
                kbibtex \
                kitty \
                libreoffice-TexMaths \
                kubernetes-client \
                docker-compose \
                fail2ban \
                fastfetch \
                podlet \
                gdisk \
                code \
                htop \
                thunderbird \
                torbrowser-launcher \
                qbittorrent \
                arianna \
                koko \
                kamoso \
                kdiskmark

dnf -y install intel-oneapi-common-vars \
                intel-oneapi-common-oneapi-vars \
                intel-oneapi-diagnostics-utility \
                intel-oneapi-compiler-dpcpp-cpp \
                intel-oneapi-dpcpp-ct \
                intel-oneapi-mkl \
                intel-oneapi-mkl-devel \
                intel-oneapi-mpi \
                intel-oneapi-mpi-devel \
                intel-oneapi-dal \
                intel-oneapi-dal-devel \
                intel-oneapi-ippcp \
                intel-oneapi-ippcp-devel \
                intel-oneapi-ipp \
                intel-oneapi-ipp-devel \
                intel-oneapi-tlt \
                intel-oneapi-ccl \
                intel-oneapi-ccl-devel \
                intel-oneapi-dnnl-devel \
                intel-oneapi-dnnl \
                intel-oneapi-tcm \

#### Example for enabl a System Unit File

systemctl disable ModemManager.service \
                  lvm2-lvmpolld.socket \
                  lvm2-monitor.service \
                  fstrim.service \
                  cups.socket
