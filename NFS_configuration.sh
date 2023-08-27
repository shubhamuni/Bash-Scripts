# Installing NFS Server on Linux Debian 12

apt-get update 
 
apt install nfs-kernel-server 

# Create a Directory for NFS Share

echo "Please Enter to make path to folder which you want to share"

echo "EX -/nfs_share"

read folder
mkdir $folder 

#Set Permissions for NFS Share

chown nobody:nogroup $folder 
chmod 777 $folder 


#Giving IP Address from user

echo "Enter client IP Address which you want to share file with"
read ip
echo '$folder $ip(rw,sync,no_subtree_check)' >> /etc/exports

#Export the NFS Share

exportfs -a 

# Enable and Start the NFS Service

systemctl enable nfs-kernel-server 
systemctl start nfs-kernel-server 


echo "Completed Setup on server"
echo "please mount nfs folder on client side on /mnt folder."
#INstalled NFS Server on Server side...
