#!/bin/bash

#
# 
# Description: ksplice-demo Vagrant box installs Oracle Linux 8.0 for a ksplice demo
# Author: Carlos Alberto Ramirez Rendon
# 
#

echo "Configuring Ksplice script setup..."
echo 'wget -N https://www.ksplice.com/uptrack/install-uptrack' > /root/install_ksplice.sh
echo 'read  -p "Type a valid Ksplice Access Key and press Enter: " ' >> /root/install_ksplice.sh
echo 'echo "";' >> /root/install_ksplice.sh
echo ' sh install-uptrack ${REPLY}' >> /root/install_ksplice.sh
echo ""

#enable repos
yum config-manager --enable ol8_appstream
yum config-manager --enable ol8_baseos_latest
# configuring and installing Ksplice
yum clean all

#install GUI

yum groupinstall -y "Server with GUI"

echo 'Installing packages required for webapp demo'
yum install git  -y
yum install gcc -y 
yum install httpd  -y
yum install php  -y
yum install php-json -y
yum install php-xml -y
yum install php-pdo -y
yum install php-mbstring -y
systemctl start httpd
systemctl enable httpd
cd /var/www/ && { git clone https://github.com/ilosuna/phpsqlitecms.git ; mv /var/www/html{,.old}; ln -s /var/www/phpsqlitecms /var/www/html; }

#Settig SELinux in permissive mode
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

#MOTD

echo "Welcome to Oracle Linux Server release 8" > /etc/motd
echo "" >> /etc/motd
echo "#####################################################################################################################"  >> /etc/motd
echo '* Double click on ksplice-demo vm, then loggin as vagrant user password Welcome1' >> /etc/motd 
echo "  - Run the /root/install_ksplice.sh script and provide a valid Ksplice Access Key as root user to install Ksplice" >> /etc/motd

systemctl set-default graphical.target

####tune screen
cat << EOF > /etc/gdm/custom.conf
[daemon]
# Uncoment the line below to force the login screen to use Xorg
WaylandEnable=false
DefaultSession=gnome=xorg.desktop
[security]

[xdmcp]

[chooser]

[debug]
# Uncomment the line below to turn on debugging
#Enable=true


EOF

grub2-set-default 1


#setting password for  Vagrant user
echo "Welcome1" | passwd --stdin vagrant
echo "Welcome1" | passwd --stdin root 

#building exploit
echo "Building exploit"
su - vagrant -c "git clone https://github.com/nu11secur1ty/Ubuntu.git"
su - vagrant -c "gcc  /home/vagrant/Ubuntu/CVE-2019-13272/CVE-2019-13272.c  -o ~/exploit"

clear
echo ""
echo ""
echo "##################################################################"
echo 'OL ksplice demo VM will be ready after reboot'
echo 'To get started, on your VirtualBox Manager :'
echo '  Double click on ksplice-demo VM, then loggin as vagrant user password Welcome1'
echo "  Run the /root/install_ksplice.sh script and provide a valid Ksplice Access Key as root user to install Ksplice"
sleep 3
echo ' rebooting VM'
reboot


