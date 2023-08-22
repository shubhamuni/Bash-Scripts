#!/bin/bash

#Installing Packages and Dependencies 

apt update
apt install vsftpd
apt install ufw
#Setting up FTP Service

systemctl start vsftpd
systemctl enable vsftpd

# Ask the user for FTP name
echo "Please enter FTP username"
read ftpuser
adduser $ftpuser
echo  "$ftpuser have been created for FTP"

#Granting  Permissions to FTP User 
echo "$ftpuser" | tee -a /etc/vsftpd.userlist

#Receiving Desired Path From User

echo "if you want share upload ditectory then Ex./home/ftpuser/ftp/"
echo "Enter the path that you want share through FTP"
read sharepath

#Creating Folder at given path
mkdir -p $sharepath

#Granting Permissions to Folder which is created 
chmod 550 $sharepath
chmod -R 750 $sharepath
chown -R $ftpuser: $sharepath

#Adding New Lines in End of vsftpd.conf File
echo 'user_sub_token=$ftpuser' >> /etc/vsftpd.conf
echo 'local_root=$sharepath' >> /etc/vsftpd.conf
echo 'userlist_enable=YES' >> /etc/vsftpd.conf
echo 'userlist_file=/etc/vsftpd.userlist' >> /etc/vsftpd.conf
echo 'userlist_deny=NO' >> /etc/vsftpd.conf
echo 'allow_writeable_chroot=YES' >> /etc/vsftpd.conf
systemctl restart vsftpd

#Allowing to FTP Ports to firewall
ufw allow 20/tcp
ufw allow 21/tcp

#Setting Up FTP Server and We're Ready to go....
systemctl status vsftpd






