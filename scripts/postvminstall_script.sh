### Update repo for host vm ###
apt-get update

### Install essential packages for hostvm ###
apt-get install -y net-tools
apt-get install -y nmap

### Configure hostvm for elk ###
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sudo sysctl -p
sysctl vm.max_map_count

