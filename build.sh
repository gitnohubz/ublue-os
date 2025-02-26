set -ouex pipefail
mkdir -p /var/opt

### add custom yum repos :
tee /etc/yum.repos.d/vscode.repo << EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
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

tee /usr/lib/tmpfiles.d/brave-browser.conf << EOF
L  /opt/brave-browser  -  -  -  -  /usr/lib64/brave-browser
EOF

dnf -y config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

##############################
##############################

dnf -y group install --setopt=max_parallel_downloads=20 c-development development-tools vlc virtualization libreoffice
dnf -y install --setopt=max_parallel_downloads=20 vdpauinfo \
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
                fastfetch \
                podlet \
                gdisk \
                code \
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
                sbctl \
                unrar \
                chromium \
                htop \
                fail2ban \
                brave-browser


dnf -y install --allowerasing OpenCL-ICD-Loader
dnf -y remove   amd* \
                nvidia* \
                kde-partitionmanager \
                kate \
                krfb

#####################################
#####################################

systemctl disable lvm2-lvmpolld.socket \
                  cups.socket \
                  iscsid.socket \
                  iscsiuio.socket \
                  raid-check.timer \
                  ModemManager.service \
                  lvm2-monitor.service \
                  fstrim.service 

systemctl enable libvirtd.socket \
                 fwupd-refresh.timer \
                 fail2ban.service \
                 rngd.service

#####################################
#####################################
mv /var/opt/* /usr/lib64/