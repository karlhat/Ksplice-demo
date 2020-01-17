#!/bin/bash

#
# 
# Description: ksplice-demo Vagrant box installs Oracle Linux 7 latest with kernel-3.10.0-229.el7 from ol7_u1_base repo for a ksplice demo
# Author: Carlos Alberto Ramirez Rendon
# 
#

echo "Configuring Ksplice script setup..."
echo 'wget -N https://www.ksplice.com/uptrack/install-uptrack' > /root/install_ksplice.sh
echo 'read  -p "Type a valid Ksplice Access Key and press Enter: " ' >> /root/install_ksplice.sh
echo 'echo "";' >> /root/install_ksplice.sh
echo ' sh install-uptrack ${REPLY}' >> /root/install_ksplice.sh
echo ""


# configuring and installing Ksplice
yum clean all

echo 'Installing packages required'
yum install git  -y
yum install gcc -y 
yum install httpd  -y
yum install -y oracle-php-release-el7
yum install php  -y
yum install php-json -y
yum install php-ZendFramework2-Dom  -y
yum install php-pdo -y
yum install php-mbstring -y
systemctl start httpd
systemctl enable httpd
cd /var/www/ && { git clone https://github.com/ilosuna/phpsqlitecms.git ; mv /var/www/html{,.old}; ln -s /var/www/phpsqlitecms /var/www/html; }

#Settig SELinux in permissive mode
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

#MOTD

echo "Welcome to Oracle Linux Server release 7" > /etc/motd
echo "" >> /etc/motd
echo "#####################################################################################################################"  >> /etc/motd
echo '* Double click on ksplice-demo vm, then loggin as vagrant user password Welcome1' >> /etc/motd 
echo "  - Run the /root/install_ksplice.sh script and provide a valid Ksplice Access Key as root user to install Ksplice" >> /etc/motd

 
yum --enablerepo=ol7_u1_base install kernel-3.10.0-229.el7 -y
grub2-set-default 0

#setting password for  Vagrant user
echo "Welcome1" | passwd --stdin vagrant
echo "Welcome1" | passwd --stdin root 

#building exploit
echo "Building exploit"
su - vagrant -c "git clone https://gist.github.com/e9d4ff65d703a9084e85fa9df083c679.git"
su - vagrant -c "gcc -pthread /home/vagrant/e9d4ff65d703a9084e85fa9df083c679/cowroot.c  -o ~/exploit"

clear
echo ""
echo ""
echo "##################################################################"
echo 'OL ksplice demo VM will be ready after reboot'
echo 'To get started, on your VirtualBox Manager :'
echo '  Double click on ksplice-demo vm, then loggin as vagrant user password Welcome1'
echo "  Run the /root/install_ksplice.sh script and provide a valid Ksplice Access Key as root user to install Ksplice"
sleep 3
echo ' rebooting VM'
reboot


