#!/bin/bash
#Ahmad Shafie S11 CFC3110 James Lim

sudo apt-get update
sudo apt-get upgrade

echo "#####################################################################################################################"
echo -e "Checking if all required tools are installed"
echo "#####################################################################################################################"
{
	if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep -x tor) == "tor" ];
	then
	
	echo "ToriFY is already installed "
	
	else
	
	echo "Installing ToriFY."
	
	git clone https://github.com/Debajyoti0-0/ToriFY.git
	fi

}


{
	if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep geoip-bin) == "geoip-bin" ];
	then
	
	echo "geoip-bin is already installed "
	
	else
	
	echo "Installing geoip-bin."
	
	sudo apt-get install geoip-bin
	fi

}

{
	if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep sshpass) == "sshpass" ];
	then
	
	echo "sshpass is already installed "
	
	else
	
	echo "Installing sshpass."
	
	sudo apt-get install sshpass
	fi

}

{
	if [ $(find nipe/cpanfile) == "nipe/cpanfile" ];
	then
	
	echo "nipe is already installed "
	
	else
	
	echo "Installing nipe."
	
	git clone https://github.com/htrgouvea/nipe
	sudo cpan install Try::Tiny Config::Simple JSON
	sudo perl nipe.pl install
	fi

}

sudo perl nipe.pl start

{
	
	ipX=$(curl ifconfig.io)
if [ $(curl ifconfig.io/country_code) == "SG" ];

then

echo "Your IP is not Spoofed"
exit

else 
echo "Your Connection is secure"

echo "Your Spoofed IP Address is: $ipX "

echo "Your Spoofed Country: "
geoiplookup "$ipX"

echo "Connecting to Remote Server"

sshpass -p 'tc' ssh -o StrictHostKeyChecking=no tc@192.168.234.130 uptime

echo "Your IP address"
sshpass -p 'tc' ssh -o StrictHostKeyChecking=no tc@192.168.234.130 curl -s ifconfig.io

echo 'Country:'
sshpass -p 'tc' ssh -o StrictHostKeyChecking=no tc@192.168.234.130 geoiplookup 103.252.200.126

sshpass -p 'tc' ssh -o StrictHostKeyChecking=no tc@192.168.234.130 whois 103.252.200.126 > /home/kali/whois.txt
echo "Your Whois data is saved into:"
locate whois.txt

sshpass -p 'tc' ssh -o StrictHostKeyChecking=no tc@192.168.234.130 nmap scanme.nmap.com -Pn -p 1-100 > /home/kali/scanme.txt

echo "Your Nmap data is saved into:"
locate scanme.txt

fi

}

