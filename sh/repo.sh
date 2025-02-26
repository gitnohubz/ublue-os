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