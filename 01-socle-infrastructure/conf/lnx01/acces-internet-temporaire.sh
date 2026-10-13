#!/bin/bash
# Ouverture TEMPORAIRE de l'accès Internet sur LNX01 via la carte NAT (ens37).
# Aucun client DHCP n'est installé : l'adresse est fixée à la main.
# Tout est volatil (les routes ajoutées disparaissent au redémarrage),
# SAUF /etc/resolv.conf : le restaurer à la fin (voir plus bas).
# À exécuter en root, ligne par ligne, pas comme un script automatique.
#
# Hypothèse : le réseau VMware NAT (VMnet8) est 192.168.88.0/24,
# passerelle NAT en .2. Adapter si le sous-réseau est différent.

cp /etc/resolv.conf /root/resolv.conf.bak
ip link set ens37 up
ip addr add 192.168.88.50/24 dev ens37
ip route del default via 192.168.10.2      # (ou .1 selon la configuration d'origine)
ip route add default via 192.168.88.2
echo "nameserver 192.168.88.2" > /etc/resolv.conf

ping -c 2 192.168.88.2
ping -c 2 8.8.8.8
ping -c 2 deb.debian.org

# ... apt update / apt install openssh-server bind9-dnsutils chrony ...

# FERMETURE : remettre le DNS du domaine et couper la carte
cat > /etc/resolv.conf << 'EOT'
search ad.econova.fr
nameserver 192.168.10.10
EOT
ip link set ens37 down
# puis déconnecter la carte réseau 2 dans VMware
