#!/bin/bash
#    - EFI partition (/dev/nvme0n1p1) - will be formatted as FAT32
#    - ROOT partition (/dev/nvme0n1p2) - will be formatted as Btrfs
# 
#   You must create these partitions before running the script (using fdisk, gdisk, or parted). The script will then format and install Arch Linux on them.

# --- PRE-INSTALL CLEANUP ---
swapoff -a
umount -R /mnt 2>/dev/null || true
mount -o remount,size=2G /run/archiso/cowspace

# --- TARGET HARDWARE ---
DEV="/dev/nvme0n1"
EFI="${DEV}p1"
ROOT="${DEV}p2" 

echo "Step 1: Formatting..."
mkfs.fat -F32 "$EFI"
mkfs.btrfs -f -L ARCH "$ROOT"

echo "Step 2: Subvolumes..."
mount "$ROOT" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@pkg
btrfs subvolume create /mnt/@snapshots
umount /mnt

echo "Step 3: Mounting..."
mount -o noatime,compress=zstd,subvol=@ "$ROOT" /mnt
mkdir -p /mnt/{home,var/log,var/cache/pacman/pkg,.snapshots,boot/efi,etc}
mount -o noatime,compress=zstd,subvol=@home "$ROOT" /mnt/home
mount -o noatime,compress=zstd,subvol=@log "$ROOT" /mnt/var/log
mount -o noatime,compress=zstd,subvol=@pkg "$ROOT" /mnt/var/cache/pacman/pkg
mount -o noatime,compress=zstd,subvol=@snapshots "$ROOT" /mnt/.snapshots
mount "$EFI" /mnt/boot/efi

# Pre-create configuration files
echo "KEYMAP=us" > /mnt/etc/vconsole.conf

echo "Step 4: Pacstrap..."
pacman -Sy
pacstrap /mnt base base-devel linux linux-firmware btrfs-progs grub efibootmgr dialog wpa_supplicant ppp dhcpcd

genfstab -U /mnt >> /mnt/etc/fstab

echo "Step 5: Chroot Configuration..."
arch-chroot /mnt /bin/bash <<EOF
# Locale & Time
ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "archlinux" > /etc/hostname

# --- SWAP FILE ---
btrfs filesystem mkswapfile --size 32G /swapfile 2>/dev/null || {
    truncate -s 0 /swapfile
    chattr +C /swapfile
    btrfs property set /swapfile compression ""
    fallocate -l 32G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
}
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

# --- INITCPIO ---
sed -i 's/^MODULES=()/MODULES=(btrfs)/' /etc/mkinitcpio.conf
sed -i 's/HOOKS=(base udev/HOOKS=(base udev btrfs resume/' /etc/mkinitcpio.conf
mkinitcpio -P

# --- THE GRUB FIX ---
# 1. Manually create the directory so the map file has a home
mkdir -p /boot/grub

# 2. Create the device map
echo "(hd0) $DEV" > /boot/grub/device.map

# 3. Install GRUB using the explicit device map
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable --recheck

# 4. Generate the config
grub-mkconfig -o /boot/grub/grub.cfg

echo "root:password" | chpasswd
# systemctl enable NetworkManager
EOF

echo "Done! Unmounting..."
umount -R /mnt
