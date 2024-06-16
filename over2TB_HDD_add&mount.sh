#!/bin/bash
lsblk
echo -e "\n\n\n\n\n"
read -p "Enter the HDD device name(e.g. sdb):" device_name

# 1. Start partitioning
echo -e "\033[1;46;30mStarting partitioning of $device_name..."
sudo parted /dev/$device_name --script -- mklabel gpt
sudo parted /dev/$device_name --script -- mkpart primary ext4 1MiB 100%

# 2. Wait for partition to be recognized
echo -e "\033[1;46;30mWaiting for partition to be recognized..."
sleep 3

# 3. Add partition name
partition_name="${device_name}1"

# 4. Format the partition
echo -e "\033[1;46;30mStarting format of /dev/$partition_name ...\033[0m"
sudo dd if=/dev/zero of=/dev/$partition_name bs=1M count=10 #Clean the first 10MB of data, including signing data
yes | sudo mkfs.ext4 /dev/$partition_name

# 5. Get the UUID of the partition
partition_uuid=$(sudo blkid -o value -s UUID /dev/$partition_name)

# 6. Create the mount directory
mount_dir="/mnt/$partition_name"
sudo mkdir -p $mount_dir

# 7. Edit /etc/fstab
echo -e "\033[1;46;30mAdd /dev/$partition_name to /etc/fstab...\033[0m"
echo "UUID=$partition_uuid $mount_dir ext4 defaults 0 0" | sudo tee -a /etc/fstab

# 8. Mount the HDD
sudo mount /dev/$partition_name $mount_dir
echo -e "\033[1;46;30mOperation completed! The new hard drive has been permanently mounted to $mount_dir.\033[0m"
echo -e "\033[1;46;30m操作完成! 新硬碟已永久掛載到$mount_dir。\033[0m"