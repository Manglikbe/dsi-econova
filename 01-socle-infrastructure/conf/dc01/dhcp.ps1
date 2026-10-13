# Équivalent PowerShell de la configuration DHCP de DC01.
# ATTENTION : la configuration réelle a été réalisée via l'interface graphique ;
# ce script est une référence reproductible, non exécuté tel quel dans le labo.

Install-WindowsFeature DHCP -IncludeManagementTools

# Autoriser le serveur DHCP dans Active Directory (indispensable pour un DHCP de domaine)
Add-DhcpServerInDC -DnsName "dc01.ad.econova.fr" -IPAddress 192.168.10.10

# Étendue des postes : .100 à .199 (bail observé : 15 jours)
Add-DhcpServerv4Scope -Name "Postes" `
    -StartRange 192.168.10.100 -EndRange 192.168.10.199 `
    -SubnetMask 255.255.255.0 -LeaseDuration (New-TimeSpan -Days 15) -State Active

# Options distribuées : passerelle, DNS, suffixe de domaine
Set-DhcpServerv4OptionValue -ScopeId 192.168.10.0 `
    -Router 192.168.10.2 -DnsServer 192.168.10.10 -DnsDomain "ad.econova.fr"
