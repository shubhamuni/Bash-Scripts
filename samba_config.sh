apt update 

apt upgrade -y

apt install samba -y

systemctl  start smbd
systemctl  enable smbd

cp /etc/samba/smb.conf /opt/smb_bak.conf

echo "We have to create new Samba User"
echo "Enter Samba username"
read user

adduser $user

smbpasswd -a $user
echo "Enter the directory path to create samba share"
echo "Ex. /media/share/"

read $share
mkdir -p $share

echo "Enter shared folder name"
read folder

echo "[$folder]" > /etc/samba/smb.conf
echo "path = $share" > /etc/samba/smb.conf
echo "read only = no" > /etc/samba/smb.conf
echo "guest ok = no" > /etc/samba/smb.conf
echo "valid users = $user" > /etc/samba/smb.conf

systemctl restart smbd
systemctl start smbd
 



 

