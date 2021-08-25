##  Setup USB boot:

`dd bs=4M if=/ARCHLINUX.iso  of=/dev/sdb oflag=direct status=progress`

## Format and partition:

**create efi boot partition (/dev/sdxY 250~510MB) use fdisk, and format F32 (require dosfstools)**
```
mkfs.fat -F32 /dev/sdxY
```

**Arch linux partition**
```
mkfs.ext4 /dev/sdaX
```
**create swap partition**
```
mkswap /dev/sdaY
swapon  /dev/sdaY
```

**Connect to internet**
*wifi*
```
wifi-menu
```

*ethernet*
```
dhcpdp eth0
```

*check network*
```
ping 1.1.1.1 -c 2
```

**Mount to installing partition**
```
mount /dev/sdaX /mnt
```

**Install base linux linux-firmware**
```
pacstrap /mnt base base-devel linux linux-firmware 
```

**Create fstab file**
```
genfstab -U /mnt >> /mnt/etc/fstab
```

**Chroot to new system**
```
arch-chroot /mnt
```

**Install some basic package**
```
pacman -S dialog wpa_supplicant ppp dhcpcd
```

**set hostname**
```
vi /etc/hostname
```

**config timezone**
```
ln -sf /usr/share//zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
```

**locale**
*uncomment en_US.\* in /etc/locale.gen*
```
echo LANG=en_US.UTF-8 > /etc/locale.conf
locale-gen
```

**create an initial ramdisk environment**
```
mkinitcpio -P
```

**Grub**
```
pacman -S grub efibootmgr
mkdir /boot/EFI
mount /dev/sdaX /boot/EFI  *Mount FAT32 EFI partition*
grub-install --target=i386-pc /dev/sdX *for legacy boot*
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck 
*or*
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --no-nvram --removable *for UEFI boot*
grub-mkconfig -o /boot/grub/grub.cfg

exit
umount -R /mnt
reboot
```
## Install graphical enviroment:

**Xorg**
```
sudo pacman -S xorg-server xorg-apps xorg-xinit
```

**DM**
```
sudo pacman -S lightdm lightdm-gtk-greeter
```

**fonts**
```
sudo pacman -S noto-fonts noto-fonts-emoji ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-inconsolata ttf-roboto terminus-font ttf-font-awesome ttf-nerd-fonts-symbols xorg-mkfontscale terminus-font 
```

**Audio**
```
sudo pacman -S alsa alsa-utils alsa-plugins alsa-lib pavucontrol
```

**Tools**
```
sudo pacman -S archlinux-keyring
sudo pacman -S rxvt-unicode ranger rofi conky dmenu urxvt-perls perl-anyevent-i3 perl-json-xs atool highlight mediainfo w3m ffmpegthumbnailer zathura fzf firefox mpv mplayer feh sxiv scrot mtpfs gvfs-mtp pulseaudio git ibus-unikey ncmpcpp mpd mpc python-pip aria2 wget curl openvpn usbutils ctags youtube-dl streamlink  perl-file-mimeinfo perl-image-exiftool xclip xdotool notify-osd crda geoip p7zip xbindkeys python2-wheel python-wheel re2 fbreader  bash-completion zathura-pdf-mupdf zathura-djvu zathura-cb npm ipython3 neovim gopls ccls bash-language-server pyright
```

**for pystatus i3**
```
pip install --user python-mpd2 
```

**config audio**
```
vim /etc/modprobe.d/alsa-base.conf

options snd_mia index=0
options snd_hda_intel index=1
```

**enable and start DM**
```
systemctl enable lightdm
systemctl start lightdm
```

**create user**
```
useradd -m -g wheel duy
```

**install yay**
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syyuu
```
**yay tools**
```
yay -S urxvt-font-size-git python-pdftotext scrcpy libxft-bgra-git  ttf-symbola xurls mtpfs ifuse android-file-transfer lf

```

**access onion use firefox**
> enable tor service 
> config proxy firefox localhost 9050 socks5
> about:config, network.proxy.socks_remote_dns=true, network.trr.mode=0, network.dns.blockDotOnion=false
					


## Note
> fastest way transfe file 
```
**sender**
tar czf - filename | netcat -l -p port -vvv -c
**reciever**
netcat host port | tar xz
```

> misc
```
aria2c --bt-metadata-only=true --bt-save-metadata=true
> ssh with tar
tar c | ssh user@server "tar x"
tar c | ssh user@server "tar x -C /path"                        
```

> weechat
```
to load the script
/python autoload
to store the channels to join
/autojoin --run  
to store the order of the channels
/layout store    
to save your setting
/save
```

> qemu boot from usb
```
sudo qemu-system-x86_64 -m 4096 -enable-kvm -usb -device usb-host,hostbus=1,hostaddr=21
```

## Encrypt LVM on LUKS
[LVM on LUKS](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)

> config /etc/mkinipico.conf
```
vim /etc/mkinitcpio.conf
```
> Add 'ext4' to MODULES
> Add 'encrypt' and 'lvm2' to HOOKS before 'filesystems'
> etc/default/grub
```
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda2:luks:allow-discards"
```

> nvidia
```
pms nvidia nvidia-utils nvidia-settings xorg-server-devel opencl-nvidia 
```

> check disable nouveau
```
cat /usr/lib/modprobe.d/nvidia.conf
```

> etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
```
Section "OutputClass"
    Identifier "intel"
    MatchDriver "i915"
    Driver "modesetting"
EndSection

Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    Option "PrimaryGPU" "yes"
    ModulePath "/usr/lib/nvidia/xorg"
    ModulePath "/usr/lib/xorg/modules"
EndSection
```

> .xinitrc
```
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
```
> check 3D
```
glxinfo | grep NVIDIA
```


# Markdown tutorials

# H1
## H2
**bold** 
__bold too__
~~strikethrought~~


## List
1. hello
2. world
3. mother
4. fucker

## Link

[hello, world](https://google.com)
[api](http://wifimkt.bizflycloud.vn:5002/health)
[test]: http://google.com


## Images
![image1](https://google.com/images1.png)
## Code and Syntax Highlighting
```python
a="hello"
print(a)
```

## Tables
| Stt | Name | Age |
| ------- | ------- | ------- |
| 1 | Duy | 26 |

## Blockquotes
> Blockquotes are vrey handy in email to emulate
> This line is part of the same quotes

Quote break.

> This is very long line that will sill be quoted properly when it wraps. Oh boy let's keep writeing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into blockquote.

## Horizontal Rule
Three or more...
---
Hyphens
***
Asterisks
________
Underscores

## Line Breaks

Here's aline for us to start with.

This line is separated from the one above by two newlines, so it will be a "separate paragraph".

This line is also a separate paragraph, but ...
This line is only separated by a single newline, so
It's separate line in the *same paragraph*.
