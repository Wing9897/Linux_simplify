#!/bin/bash
read -p "Enter the HDD device name(e.g. sdb):" device_name

# 1.<<EOF = End of file , for terminator of fdisk
echo -e "\033[1;46;30mStarting partitioning of $device_name..."
sudo fdisk /dev/$device_name << EOF
d
n
p
1
  
  
w
EOF
echo -e "\033[1;46;30mDone!\033[0m"

# 2.add partition name
partition_name="${device_name}1"

# 3. format the partition
echo -e "\033[1;46;30mStarting format of /dev/$partition_name ...\033[0m"
sudo dd if=/dev/zero of=/dev/$partition_name bs=1M count=10 #Clean the first 10MB of data, including signing data
yes | sudo mkfs.ext4 /dev/$partition_name

# 4. Get the UUID of the partition
partition_uuid=$(sudo blkid -o value -s UUID /dev/$partition_name)

# 5. Create the mount directory
mount_dir="/mnt/$partition_name"
sudo mkdir -p $mount_dir

# 6. Edit /etc/fstab
echo -e "\033[1;46;30mAdd /dev/$partition_name to /etc/fstab...\033[0m"
echo "UUID=$partition_uuid $mount_dir ext4 defaults 0 0" | sudo tee -a /etc/fstab

# 7. Mount the HDD
sudo mount /dev/$partition_name $mount_dir
echo -e "\033[1;46;30mOperation completed! The new hard drive has been permanently mounted to $mount_dir.\033[0m"
echo -e "\033[1;46;30m操作完成! 新硬碟已永久掛載到$mount_dir。\033[0m"