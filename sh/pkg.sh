### groups :
#dnf5 -y group install --with-optional
dnf5 -y group install c-development development-tools vlc virtualization libreoffice

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

                
#                https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
#                https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### resolve confilcts
dnf5 -y install --allowerasing OpenCL-ICD-Loader

### delete pkgs :
dnf5 -y remove amd* \
               nvidia* \
               kde-partitionmanager \
               kate \
               krfb 