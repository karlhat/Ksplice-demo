# Ksplice-demo
ksplice-demo Vagrant box installs Oracle Linux 7 latest with kernel-3.10.0-229.el7 from ol7_u1_base repo for a ksplice demo


## Prerequisites
1. Install [Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads) on your Host
2. Install [Vagrant](https://vagrantup.com/) on your Host
3. Install [Git](https://git-scm.com/downloads) on your host
4. A valid Ksplice Access Key, retrieve it from [KSplice Web Site](http://ksplice.oracle.com/)

## Getting started
### Preparation before to run demo
1. Clone this repository `git clone https://github.com/karlhat/Ksplice-demo.git`
2. Change into the `Ksplice-demo` folder
3. Run `vagrant up; vagrant ssh`
4. Within the guest, as `root` with password `Welcome1`  run the following command:<br/>
  4.1  [root@ksplice-demo ~]# bash install_ksplice.sh
5. Open the VirtualBox Manager
### Running the demo
6. Double click on `ksplice-demo` Virtual Machine
7. Login as `vagrant` user with password `Welcome1`
8. In your laptop open the URL `http://localhost:8000/` <br/>
    tell to customer that web portal is running on Oracle Linux vm
9. Back to `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
  9.1 `Inspect the Oracle Linux server` <br/>
    Use the Ksplice Inspector to review the security patches available for the installed kernel on the server, this can be done online via the [Ksplice inspector online](http://ksplice.oracle.com/inspector)  or via a CLI command connecting to the Ksplice API server.In the list with available Ksplice updates you will find several CVEs including the one We are interested in (CVE-2016-5195)
  9.2 In the virtual console as `vagrant` user run the exploit: ./exploit <br/>  
  9.3 Show the Privilege Escalation from the exploit, after few seconds (about 30 seconds)<br/>
      the exploit will generate a Kernel panic <br/>
  9.4 In your laptop try to open the URL `http://localhost:8000/` until `can't accesss site` message appears <br/>
  9.5 Power off `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
10. Power Up `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
11. Run `vagrant up; vagrant ssh` <br/>
12. Within the guest, Show the  installed kernel using the `uname -r` <br/>
  12.1 Within the guest as root user patch online the kernel using `uptrack-upgrade -v` command <br/>
  12.1.1 Show the updated Kernel running with the command `uptrack-uname -r` <br/>
  12.1.2 Back to `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
  12.1.3 Login as `vagrant` user with password `Welcome1` <br/>
  12.1.4 In the virtual console as `vagrant` user run the exploit: ./exploit <br/>
  12.1.5 Explain to customer the vulnerability was fixed without reboot <br/>
13. In your laptop open the URL `http://localhost:8000/` <br/>




## Feedback
Please provide feedback of any kind via Github issues on this repository.

