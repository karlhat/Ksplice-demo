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
  4.1  [root@ksplice-demo ~]# bash install_ksplice.sh <br/>
  4.2  [root@ksplice-demo ~]# uptrack-upgrade -n  
 
### Running the demo
1. Open the VirtualBox Manager
2. Double click on `ksplice-demo` Virtual Machine
3. Login as `vagrant` user with password `Welcome1`
4. In your laptop open the URL `http://localhost:8000/` <br/>
    tell to customer that web portal is running on Oracle Linux vm
5. Back to `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
  5.1 `Inspect the Oracle Linux server` <br/>
    Use the Ksplice Inspector to review the security patches available for the installed kernel on the server, this can be done online via the [Ksplice inspector online](http://ksplice.oracle.com/inspector)  or via a CLI command connecting to the Ksplice API server.In the list with available Ksplice updates you will find several CVEs including the one We are interested in (CVE-2016-5195)
  5.2 In the virtual console as `vagrant` user run the exploit: ./exploit <br/>
  5.3 Show the Privilege Escalation from the exploit, after few seconds (about 30 seconds) the exploit will generate a Kernel panic <br/>
  5.4 In your laptop try to open the URL `http://localhost:8000/` until `can't accesss site` message appears <br/>
  5.5 Power off `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
6. Power Up `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
7. Run `vagrant up; vagrant ssh` <br/>
8. Within the guest, Show the  installed kernel using the `uname -r` <br/>
  8.1 Within the guest as root user patch online the kernel using `uptrack-upgrade -v` command <br/>
  8.1.1 Show the updated Kernel running with the command `uptrack-uname -r` <br/>
  8.1.2 Back to `ksplice-demo` Virtual Machine by VirtualBox Manager <br/>
  8.1.3 Login as `vagrant` user with password `Welcome1` <br/>
  8.1.4 In the virtual console as `vagrant` user run the exploit: ./exploit <br/>
  8.1.5 Explain to customer the vulnerability was fixed without reboot <br/>
9. In your laptop open the URL `http://localhost:8000/` <br/>

## clean up
 Remove  applied kernel patches using the following command:
 
 `[root@ksplice-demo ~]# uptrack-remove  --all `


## Feedback
Please provide feedback of any kind via Github issues on this repository.

