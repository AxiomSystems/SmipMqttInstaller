#!/bin/sh
echo Removing .NET Core 3.1
lastUsers=$(last -1 -n 1 --nohostname)
set -- $lastUsers
currUser=$1
currHome="/home/$currUser"

rm -rf $currHome/.dotnet
rm /usr/bin/dotnet
rm /etc/profile.d/dotnet.sh
