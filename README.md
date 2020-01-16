# Ksplice-demo
ksplice-demo Vagrant box installs Oracle Linux 7 latest with kernel-3.10.0-229.el7 from ol7_u1_base repo for a ksplice demo


## Prerequisites
1. Install [Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://vagrantup.com/)
3. A valid Ksplice Access Key, retrive it from [KSplice](http://ksplice.oracle.com/)

## Getting started
1. Clone this repository `git clone https://github.com/karlhat/Ksplice-demo.git`
2. Change into the `Ksplice-demo` folder
3. Run `vagrant up; vagrant ssh`
4. Within the guest, as `root` with password `Welcome1`  run the following command:
4.1  [root@ksplice-demo ~]# bash install_ksplice.sh
5. Open the VirtualBox Manager
6. Double click on `ksplice-demo` Virtual Machine
7. Login as `vagrant` user with password `Welcome1`
8. In your laptop open  the URL `http://localhost:8000/`
9. 


## Feedback
Please provide feedback of any kind via Github issues on this repository.

