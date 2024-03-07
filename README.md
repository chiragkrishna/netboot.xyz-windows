# Asus-Merlin Router setup

- enable ssh
- Enable JFFS custom scripts and configs
- reboot

ssh into router
```bash
mkdir /jffs/tftproot
curl -o /jffs/tftproot/netboot.xyz.kpxe https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe
curl -o /jffs/tftproot/netboot.xyz.efi https://boot.netboot.xyz/ipxe/netboot.xyz.efi
touch /jffs/configs/dnsmasq.conf.add
nano /jffs/configs/dnsmasq.conf.add
```
replace 10.11.12.10 with your server IP address
Copy contents into --> dnsmasq.conf.add
```
enable-tftp
tftp-root=/jffs/tftproot
dhcp-match=set:bios,60,PXEClient:Arch:00000
dhcp-boot=tag:bios,netboot.xyz.kpxe,,10.11.12.10
dhcp-match=set:efi32,60,PXEClient:Arch:00002
dhcp-boot=tag:efi32,netboot.xyz.efi,,10.11.12.10
dhcp-match=set:efi32-1,60,PXEClient:Arch:00006
dhcp-boot=tag:efi32-1,netboot.xyz.efi,,10.11.12.10
dhcp-match=set:efi64,60,PXEClient:Arch:00007
dhcp-boot=tag:efi64,netboot.xyz.efi,,10.11.12.10
dhcp-match=set:efi64-1,60,PXEClient:Arch:00008
dhcp-boot=tag:efi64-1,netboot.xyz.efi,,10.11.12.10
dhcp-match=set:efi64-2,60,PXEClient:Arch:00009
dhcp-boot=tag:efi64-2,netboot.xyz.efi,,10.11.12.10
```

```
reboot
```
test if it working

```
tftp 10.11.12.10
tftp> get netboot.xyz.kpxe
Received 368475 bytes in 0.5 seconds
```

# Docker Setup

create directory

```bash
mkdir -p /home/$LOGNAME/docker_appdata/netbootxyz/assets /home/$LOGNAME/docker_appdata/netbootxyz/config

```

docker compose

```yaml
---
services:
  netbootxyz:
    image: lscr.io/linuxserver/netbootxyz:latest
    container_name: netbootxyz
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Kolkata
    volumes:
      - /home/$LOGNAME/docker_appdata/netbootxyz/assets:/assets
      - /home/$LOGNAME/docker_appdata/netbootxyz/config:/config
    ports:
      - 3112:3000
      - 69:69/udp
      - 8888:80
    restart: unless-stopped
```

# netboot.xyz setup

Copy the files accordingly
```
netbootxyz
	├── assets
	│   ├── Win10
	│   │   ├── auto10.bat
	│   │   ├── (Extracted win10.iso)
	│   │   └── winpeshl.ini
	│   ├── Win11
	│   │   ├── auto11.bat
	│   │   ├── (extracted win11.iso)
	│   │   └── winpeshl.ini
	│   └── WinPE
	│       ├── HBCD_PE_x64
	│       ├── live11
	│       └── win-install

```
Edit boot.cfg and windows.ipxe accordingly
