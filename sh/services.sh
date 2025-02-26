#### Systemd Unit Files

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
