# Auto install arch linux with btrfs
```
bash install.sh # have to partitioned disk
```


# Manual install arch linux:

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
ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
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
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck || grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --no-nvram --removable #for UEFI boot
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

**fonts**
```
sudo pacman -S --needed noto-fonts-cjk noto-fonts noto-fonts-emoji ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-inconsolata ttf-roboto terminus-font ttf-font-awesome ttf-nerd-fonts-symbols xorg-mkfontscale  $(pacman -Ssq xorg-font) adobe-source-code-pro-fonts cantarell-fonts fontconfig gnu-free-fonts gsfonts libfontenc libxfont2 xorg-fonts-encodings xorg-mkfontscale xorg-xlsfonts ttf-jetbrains-mono
```

**Audio**
```
sudo pacman -S alsa-utils alsa-plugins alsa-lib pavucontrol
```

**Tools**
```
sudo pacman -S archlinux-keyring
sudo pacman -S --needed zsh rxvt-unicode ranger rofi conky dmenu urxvt-perls perl-anyevent-i3 perl-json-xs highlight mediainfo w3m ffmpegthumbnailer zathura fzf firefox mpv mplayer sxiv scrot mtpfs gvfs-mtp git ibus-unikey ncmpcpp mpd mpc python-pip aria2 wget curl openvpn usbutils ctags streamlink  perl-file-mimeinfo perl-image-exiftool xclip xdotool notify-osd crda geoip p7zip xbindkeys  python-wheel re2 fbreader  bash-completion zathura-pdf-mupdf zathura-djvu zathura-cb cmake telegram-desktop ipython ntfs-3g the_silver_searcher npm yarn nodejs lua-language-server rust-analyzer gopls ccls bash-language-server pyright ripgrep odt2txt jq ffmpeg delve cowsay figlet bc pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack pulseaudio-lirc  bluez bluez-utils wireless-regdb fd atool lynx translate-shell alacritty ueberzugpp imagemagick openslide

```
**Check resolve start or not**
```
sudo systemctl status systemd-resolved.service
sudo systemctl enable  systemd-resolved.service
```

**config audio**
*** remember if cp .config from arch_config. remove .config/pulse 
```
vim /etc/modprobe.d/alsa-base.conf

options snd_mia index=0
options snd_hda_intel index=1
```
**start pipewire**
```
systemctl --user enable pipewire-media-session.service
systemctl --user start pipewire-media-session.service
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
yay -S lf ibus-bamboo urxvt-font-size-git python-pdftotext scrcpy libxft-bgra-git  ttf-symbola xurls mtpfs ifuse android-file-transfer 


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

# hibernate shutdown instead of wake by keyboard or mouse

```
# /etc/systemd/sleep.conf
HibernateMode=shutdown
```

# lutris
[install driver](https://github.com/lutris/docs/blob/master/InstallingDrivers.md)
[dependencies ](https://github.com/lutris/docs/blob/master/WineDependencies.md)

 tcpdump -n -vv -i eth0 port 514
 tcpdump  -vvAls0 port -n 8912


 # Hyperland
 ```
yay -S gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio

git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
sudo make install
 ```
