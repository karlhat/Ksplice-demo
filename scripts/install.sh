#!/bin/bash

#
# 
# Description: ksplice-demo Vagrant box installs Oracle Linux 8.0 for a ksplice demo
# Author: Carlos Alberto Ramirez Rendon
# 
#
# Changelog:
# apr.14.2020: - enabling sshd password access
#              - disabling SELinux
#              - fixing cms admin access
#                . fixing permissions/ownership under /var/www/html/cms
#                . creating files and media directories under /var/www/html/cms
#              - adjusting MOTD exhibition to fit in 80 columns ssh terminal
# 

echo "Configuring Ksplice script setup..."
echo 'wget -N https://www.ksplice.com/uptrack/install-uptrack' > /root/install_ksplice.sh
echo 'read  -p "Type a valid Ksplice Access Key and press Enter: " ' >> /root/install_ksplice.sh
echo 'echo "";' >> /root/install_ksplice.sh
echo '# do not add --autoinstall option to uptrack installation script' >> /root/install_ksplice.sh
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
yum install php-fpm -y
yum install sqlite -y
systemctl enable --now httpd


cd /var/www/ && { git clone https://github.com/ilosuna/phpsqlitecms.git ; mv /var/www/html{,.old}; ln -s /var/www/phpsqlitecms /var/www/html; }
cd /var/www/html/cms/
mkdir files media
chgrp -R apache cache data files media
chmod 2775 cache data files media
chmod 664 data/*.sqlite


# Disabling SELinux, permisse mode increase disk I/O 
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config


# Enabling sshd password access
sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
systemctl restart sshd.service 2>&1 | tee -a /tmp/bootstrap.log


#MOTD

echo "" > /etc/motd
echo "Welcome to Oracle Linux Server release 8" >> /etc/motd
echo "" >> /etc/motd
echo "
########################################################################" >> /etc/motd
echo '* Double click on ksplice-demo vm, then login as vagrant user with' >> /etc/motd 
echo '  password Welcome1' >> /etc/motd 
echo "" >> /etc/motd
echo "- Run the /root/install_ksplice.sh script and provide a valid Ksplice" >> /etc/motd
echo "  Access Key as root user to install Ksplice" >> /etc/motd
echo "" >> /etc/motd

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
rm -rf /home/vagrant/Ubuntu/

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


