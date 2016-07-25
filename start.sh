
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sudo echo "iptables-restore < /etc/iptables.ipv4.nat" >> /etc/rc.local

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE  
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT  
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT  

sudo hostapd /etc/hostapd/hostapd.conf
