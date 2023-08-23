#Installing newest updates whenever available
apt update 

apt upgrade -y

#Installing samba server 
apt install samba -y

#Enabling samba server for system startup 
systemctl  start smbd
systemctl  enable smbd


#Copying backup file of samba configuration file
cp /etc/samba/smb.conf /opt/smb_bak.conf


#Creating Samba Server
echo "We have to create new Samba User"
echo "Enter Samba username"
read user

#Adding New User for Samba 
adduser $user

#Adding samba user password
smbpasswd -a $user
echo "Enter the directory path to create samba share"

#Enter path for creating samba shared files
echo "Ex. /media/share/"

read share

#Adding folder path
mkdir -p $share

#Folder name which we want to share name of folder 
echo "Enter shared folder name"
read folder


#Adding below lines to smb.conf file 
echo "[$folder]" > /etc/samba/smb.conf
echo "path = $share" > /etc/samba/smb.conf
echo "read only = no" > /etc/samba/smb.conf
echo "guest ok = no" > /etc/samba/smb.conf
echo "valid users = $user" > /etc/samba/smb.conf


#Setting up samba server and restarting
systemctl restart smbd
systemctl start smbd
 



 

