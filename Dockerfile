# Original guide: https://frillip.com/using-your-raspberry-pi-3-as-a-wifi-access-point-with-hostapd/

FROM resin/rpi-raspbian

RUN apt-get update && apt-get install -y --no-install-recommends \
    hostapd \
    dnsmasq \
    iptables \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "denyinterfaces wlan0" >> /etc/dhcpcd.conf
COPY interfaces /etc/network/interfaces
COPY hostapd.conf /etc/hostapd/hostapd.conf
COPY hostapd /etc/default/hostapd
COPY dnsmasq.conf /etc/dnsmasq.conf
COPY sysctl.conf /etc/sysctl.conf

WORKDIR /usr/src/app

COPY start.sh ./

CMD ["sh", "./start.sh"]
