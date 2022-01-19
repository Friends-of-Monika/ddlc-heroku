#!/bin/bash

# This script is executed if $COMMANDLINE environment variable was not
# overridden, and ideally you shouldn't change the abovementioned environment
# variable and rather put all your desired launch logic here.

# Since this script runs AFTER virtual display is set up and window manager
# is started, you can safely start graphical applications here. Don't forget
# to run them as separate process by adding & though! Most graphical
# applications will surely block until they terminate, thus keeping you from
# launching multiple at once.

# As an example, here you can have Xterm coprocess startup line.
xterm &
