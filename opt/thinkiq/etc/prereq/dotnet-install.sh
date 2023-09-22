#!/bin/bash
echo Configuring .NET Core 3.1
lastUsers=$(last -1 -n 1 --nohostname)
set -- $lastUsers
currUser=$1
currHome="/home/$currUser"

echo Getting .NET Package...
cd $currHome
if [ "$(arch)" == "armv7l" ]; then
   echo 32-Bit ARM Detected:
   wget https://download.visualstudio.microsoft.com/download/pr/2043e641-977d-43ac-b42a-f47fd9ee79ba/5b10d12a0626adaed720358ab8ad0b7e/dotnet-sdk-3.1.426-linux-arm.tar.gz
else
   echo 64-Bit ARM Assumed:
   wget https://download.visualstudio.microsoft.com/download/pr/79f1cf3e-ccc7-4de4-9f4c-1a6e061cb867/68cab78b3f9a5a8ce2f275b983204376/dotnet-sdk-3.1.426-linux-arm64.tar.gz
fi

echo Unpacking...
mkdir -p $currHome/.dotnet
tar zxf dotnet-sdk-3.1*.tar.gz -C $currHome/.dotnet

echo Configuring Current Environment...
echo 'export DOTNET_ROOT=$HOME/.dotnet' > $currHome/dotnet-user.sh
echo 'export PATH=$PATH:$HOME/dotnet' >> $curHome/dotnet-user.sh
echo 'export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1' >> $currHome/dotnet-user.sh
chmod +x $currHome/dotnet-user.sh
#Configure environment for the installer's use
$currHome/dotnet-user.sh
#Configure environment for the user who ran the installer
su $currUser -c $currHome/dotnet-user.sh
rm $currHome/dotnet-user.sh

echo Configuring Boot Environment...
#Configure the environment at boot
cd $HOME
echo 'export DOTNET_ROOT=$PWD/.dotnet' > $HOME/dotnet-env.sh
echo 'export PATH=$PATH:$PWD/.dotnet' >> $HOME/dotnet-env.sh
echo export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 >> $HOME/dotnet-env.sh

sudo mv $HOME/dotnet-env.sh /etc/profile.d/dotnet.sh
sudo ln -s $currHome/.dotnet/dotnet /usr/bin/dotnet

rm $currHome/dotnet-sdk-3.1*.tar.gz
$currHome/.dotnet/dotnet --version
