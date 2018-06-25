# Informatec Basel - Jedox Docker Image

Author: Philipp Frenzel

Jedox Docker Image - Centos

# Install

## Configuration

### Docker Image

* Centos 7 Docker Image (library/centos:7)

By default, Jedox Web is installed with the following settings:

- The Apache Web server component listens only to the localhost-Interface (127.0.0.1), Port 80

- The Apache Web Server communicates with the Core Server on port 8193.

- The Jedox OLAP Server listens only to the localhost-interface (127.0.0.1), Port 7777. This port is
also used by the Apache Web-Server and the Core Server to store the internal configuration data on
the Jedox OLAP Server.

- The Apache Web Server communicates with the Tomcat Server (Jedox Integrator, Jedox Analyzer
and Task Manager) on Port 8010.

- The admin account has the password "admin" (for both: for Jedox Web as well as for the Jedox
OLAP Server).

- The Jedox Integrator Web Client communicates with the Jedox Integrator Server on port 7775.

- Tomcat Service can use 1024 MB memory maximum by default.

### config.inf

Example for setup script “config.inf”:

[custom] AllUsers=True
- customInstall=true
- AdvancedMode=True
- chosenOLAPM=true
- chosenODBO=false
- chosenSVS=true
- chosenSAP=false
- chosenETL=true
- chosenPaloWeb=true
- chosenExcelAddin=true
- chosenOfficeAddin=true
- chosenSandbox=false
- chosenPaloSuiteLog=C:\Program Files (x86)\Jedox\Jedox Suite\log
- chosenPaloServerData=C:\Program Files (x86)\Jedox\Jedox Suite\olap\data
- chosenStorage=C:\Program Files (x86)\Jedox\Jedox Suite\storage
- chosenETLdata=C:\Program Files (x86)\Jedox\Jedox Suite\tomcat\webapps\etlserver\data
- tomcatInterface=127.0.0.1
- tomcatPort=7775
- apacheInterface=
- apachePort=80
- olapInterface=
- olapPort=7777
- odboInterface=127.0.0.1
- vodboPort=4242
- chosenUpdates=true
- UpdateDemoContent=True
- apacheSecret=
- ShowInfoBox=True
- [Setup] Lang=de
- Dir=C:\Jedox
- Group=Jedox
- NoIcons=0
- Tasks=

For automatic setup repetition, you can record the setup execution e.g. with the following command:
C:\Downloads\Jedox_Setup_version.exe /SAVEINF=”C:\config.inf”
If script name config.inf is given without absolute path, config.inf will be saved in the directory where the
setup file is located. Note that when recording a script for unattended installations, the advanced setup
options are always shown.

C:\Downloads\Jedox_Setup_version.exe /LOADINF=”C:\config.inf”

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