# Informatec Basel - Jedox Docker Image

Author: Philipp Frenzel

Jedox Docker Image - Centos

# Install

## Configuration

* Centos 7 Docker Image (library/centos:7)

## Run

### Running and accessing on AWC EC2

https://knowledgebase.jedox.com/knowledgebase/ssltls-running-amazon-ec2/




# Jedox Knowledge Base

When running on RedHat Enterprise Linux or CentOS Linux, Jedox will automatically integrate itself with the “System V” init system of the host operating system. This integration enables a running Jedox instance to be shutdown properly by the host system on a restart or poweroff event. It also enables the user to configure a specific Jedox instance to be started automatically when the operating system is booted.

See related article: Start/Stop Jedox on Linux

Automatic creation of init.d file
When Jedox is installed on a compatible distribution, it will automatically register itself with init as a “service”. Specifically, if the file “/etc/redhat-release” exists, the file “jedox-suite.sh” is copied in the directory “/etc/init.d/”, with the name “jedox-suite”. While now being registered with init as a service, Jedox will not be registered to automatically start when the operating system is booted up. However, this registration allows the system to recognize and automatically stop a running Jedox instance at reboot or shutdown.

Registering Jedox to start automatically
If you want a Jedox instance to be started automatically, it has to be added to the operating system’s runlevel configuration. You can use the following command:

chkconfig --level 2345 "jedox-suite" on

After executing this command, Jedox will be automatically started when the operating system is booting. As described above, the system will also attempt to stop Jedox when shutting down.

Necessary changes when relocating a Jedox installation
If you want to relocate a Jedox instance to another installation path, you must perform the following steps:

Make sure that the Jedox instance is not currently running.
Move the Jedox installation directory to the new location.
In htdocs/app/etc/config.php file, modify the value of the defined constant “CFG_STORAGE_PFX” and set the correct path of the relocated installation in single quotes with trailing slash, for example '/opt/jedox/ps_new/'.
Replace the value of the INSTALL_PATH variable in the scripts “jedox-suite.sh” and “tomcat/jedox_tomcat.sh” with the new, correct directory path. Additionally (as of Jedox 6.0), set the new path in file “./htdocs/app/etc/config.php” for the constant “CFG_STORAGE_PFX”.
 The following example describes the steps for moving a Jedox installation from directory “/opt/jedox/ps51” to “/opt/jedox/ps”:

# stop the Jedox instance
 /opt/jedox/ps51/jedox-suite.sh stop
 # move old instance to the new location
 mv /opt/jedox/ps51 /opt/jedox/ps
 # replace the INSTALL_PATH variable in jedox-suite.sh
 sed -i.bak "s:INSTALL_PATH=/opt/jedox/ps51:INSTALL_PATH=/opt/jedox/ps:g" "/opt/jedox/ps/jedox-suite.sh"
 #replace the INSTALL_PATH variable in /etc/init.d/jedox-suite.sh
 sed -i.bak "s:INSTALL_PATH=/opt/jedox/ps51:INSTALL_PATH=/opt/jedox/ps:g" "/etc/init.d/jedox-suite"
 # start the relocated instance
 /opt/jedox/ps/jedox-suite.sh start