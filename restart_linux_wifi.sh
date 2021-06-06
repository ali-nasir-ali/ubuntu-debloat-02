Linux-WiFi-Drops-Bug-Fix

WiFi connection in Linux automatically drops after a while and the user needs to turn the WiFi off and on again in order for the network to start working again. Here's a script which when run as the superuser will check for network connectivity and when the connection drops, it will automatically reconnect to the previously connected network.

To run save the script in the "home" directory in the Linux file system.

Type in the command in the terminal (Ctrl+Alt+T) to execute the script - $ sudo ./network-refresh.sh

----------


while(true)
do
	if ! [ "$(ping -c 1 google.com)" ];
	then
		echo "Network Reset"
		sudo systemctl restart network-manager
		sleep 20
	fi	
done
---
# updated a little for better perfomance

#!/bin/bash
while(true)
do
	if ! [ "$(ping -c 1 google.com)" ];
	then
		echo "Network Reset"
		sudo systemctl restart network-manager
                expect "[sudo] password for valerian: "
                send "00"
		sleep 20
	fi
done
------------


----------
----------

Description

A simple Python script that turns off the wifi on a Windows 10 computer and then turns it back on after a configurable number of seconds.
Running

You can run this with python turn-off-wifi.py. Change SECONDS_WITH_WIFI_DISABLED to alter how long the wifi remains disabled. Be sure to run it with admin rights. If you don't, you'll see "return value 5" in the command prompt and the disabling of wifi won't function properly.
Use Case

I've used this with Windows Task Scheduler to turn off my wifi for a couple minutes whenever my computer awakens from sleep or hibernation. This causes me to stop and be more mindful about the tasks that I work on when getting to my computer, helping me focus on only the highest priority tasks instead of easier lower priority tasks.
---------
import subprocess
import time


SECONDS_WITH_WIFI_DISABLED = 60
# Constants for the command prompt
CMD_BASE = 'cmd /c "{}"'  # first is remain/terminate, then is enable/disable
WIFI_CMD_BASE = 'wmic path win32_networkadapter where NetConnectionID="Wi-fI" call {}'
WIFI_CMD_ENABLE = WIFI_CMD_BASE.format('enable')
WIFI_CMD_DISABLE = WIFI_CMD_BASE.format('disable')
#  run auto-py-to-exe to convert this file to an exe


def main():
    turn_off_wifi()
    time.sleep(SECONDS_WITH_WIFI_DISABLED)
    turn_on_wifi()


def execute_cmd(cmd):
    subprocess.call(cmd, shell=True)


def turn_on_wifi():
    execute_cmd(CMD_BASE.format(WIFI_CMD_ENABLE))


def turn_off_wifi():
    execute_cmd(CMD_BASE.format(WIFI_CMD_DISABLE))

if __name__ == "__main__":
    main()
