#!/bin/bash
#
# Copyright 2020 Peleg Wasserman addapted from the tp-link wrapper by Shawn Bruce
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# See the COPYING file in the main directory for details.
#

#SCRIPT_PATH Should point to switcher control script  provided by https://github.com/NightRang3r/Switcher-V2-Python
#Remember to change the values in the swticher python script manually (IP Address and device id)
#TODO - Port the switcher python script to Python 3 for future compatibility with octoprint
SCRIPT_PATH="./switcher.py"

ACTION=$1

case $ACTION in
    on)
        echo "Turning On..."
        python ${SCRIPT_PATH} 1
        exit $?
        ;;
    off)
        echo "Turning Off..."
        python ${SCRIPT_PATH} 0
        exit $?
        ;;
    sense)
        switch_state=`python ${SCRIPT_PATH} 2 | sed 's/,/\n/g' | grep -a 'Device state is' | awk '{ print $5 } '`
	
        if [[ $switch_state == 'ON' ]]; then
            echo "On"
            exit 0
        elif [[ $switch_state == 'OFF' ]]; then
            echo "Off"
            exit 1
        else
            echo "Unknown Error"
            exit 1
        fi
        ;;
    *)
        echo "Usage $0: {on|off|sense}"
        exit 1
esac

