[abc.xyz](#q1)
# Setup USB boot:
dd if=/ARCHLINUX.iso  of=/dev/sdb status="progress" bs=4M

# Format and partition:
# if UEFI:
   > gpt
   > create /dev/sdxY (~250-512mb) for EFI filesystem ( fdisk -t) (FAT32 format (mkfs.fat -F32 /dev/sdxY( require dosfstools))
mkfs.ext4 /dev/sdaX    - Arch linux partition

mkswap /dev/sdaY       - Swap partition

swapon  /dev/sdaY

# Connect to internet:
wifi-menu         # if use wifi

dhcpdp eth0      # if use ethenet

ping 1.1.1.1 -c 2  # test network

# Mount to installing partition
mount /dev/sdaX /mnt

# Choose mirror repository you like in:
sudo reflector --country Taiwan --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Install base linux linux-firmware 
pacstrap /mnt base base-devel linux linux-firmware 

# Create fstab file:
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot to new system:
arch-chroot /mnt
# Install some basic package

pacman -S dialog wpa_supplicant ppp dhcpcd

vi /etc/hostname  #set name

ln -sf /usr/share//zoneinfo/Asia/Ho_Chi_Minh /etc/localtime  #config timezone

echo LANG=en_US.UTF-8 > /etc/locale.conf

uncomment en_US.* in /etc/locale.gen

locale-gen

mkinitcpio -P

pacman -S grub efibootmgr

mkdir /boot/EFI
mount /dev/sdaX /boot/EFI  #Mount FAT32 EFI partition 

grub-install --target=i386-pc /dev/sdX # legacy boot

```
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck #UEFI boot
## or
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --no-nvram --removable
```

grub-mkconfig -o /boot/grub/grub.cfg

exit

umount -R /mnt

reboot


# Install graphical enviroment:

sudo pacman -Syu
# Xorg
sudo pacman -S xorg-server xorg-apps xorg-xinit i3 numlockx

# DM
sudo pacman -S lightdm lightdm-gtk-greeter

# fonts
sudo pacman -S noto-fonts noto-fonts-emoji ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-inconsolata ttf-roboto terminus-font ttf-font-awesome ttf-nerd-fonts-symbols xorg-mkfontscale terminus-font 
# Audio
sudo pacman -S alsa alsa-utils alsa-plugins alsa-lib pavucontrol

# Tools
sudo pacman -S archlinux-keyring
sudo pacman -S rxvt-unicode ranger rofi conky dmenu urxvt-perls perl-anyevent-i3 perl-json-xs atool highlight mediainfo w3m ffmpegthumbnailer zathura fzf firefox mpv mplayer feh sxiv scrot mtpfs gvfs-mtp pulseaudio git ibus-unikey ncmpcpp mpd mpc python-pip aria2 wget curl openvpn usbutils ctags youtube-dl streamlink  perl-file-mimeinfo perl-image-exiftool xclip xdotool notify-osd crda geoip p7zip xbindkeys python2-wheel python-wheel re2 fbreader  bash-completion zathura-pdf-mupdf zathura-djvu zathura-cb

pip install --user python-mpd2 

# config audio

vim /etc/modprobe.d/alsa-base.conf

options snd_mia index=0

options snd_hda_intel index=1

systemctl enable lightdm

systemctl start lightdm

# create user:

useradd -m -g wheel duy

# install yay:

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

yay -Syyuu

yay -S urxvt-font-size-git python-pdftotext scrcpy libxft-bgra-git  ttf-symbola
# urls filter

yay -S xurls

# Config files:

git clone https://github.com/laduygaga/arch_config

# Connect to android device and iphone

yay -S mtpfs ifuse android-file-transfer

yay -S jmtpfs

# vimvuldle

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# docker-ce

pacman -S docker

# ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fastest way transfe file 
sender:     tar czf - filename | netcat -l -p port -vvv -c
reciever:   netcat host port | tar xz
#  misc
aria2c --bt-metadata-only=true --bt-save-metadata=true

# scp
scp user@server:/path /path or scp /path user@server:/path
ssh with tar
tar c | ssh user@server "tar x"                                 # or 
tar c | ssh user@server "tar x -C /path"                        # -C: changedir to /path

# weechat
/python autoload # to load the script
/autojoin --run  # to store the channels to join
/layout store    # to store the order of the channels
/save            # to save your setting
# qemu boot from usb
sudo qemu-system-x86_64 -m 4096 -enable-kvm -usb -device usb-host,hostbus=1,hostaddr=21

# Encrypt LVM on LUKS
https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS
# config /etc/mkinipico.conf
# vim /etc/mkinitcpio.conf
Add 'ext4' to MODULES
Add 'encrypt' and 'lvm2' to HOOKS before 'filesystems'
# /etc/default/grub
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda2:luks:allow-discards"
