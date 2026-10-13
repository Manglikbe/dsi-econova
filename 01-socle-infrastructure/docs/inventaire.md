# Inventaire, plan d'adressage et nommage

## Plan d'adressage — `192.168.10.0/24`

| Plage | Usage |
|-------|-------|
| .1 | Hôte VMware (adaptateur virtuel) |
| .2 | Passerelle (future, pare-feu au projet 2) |
| .10 – .49 | Serveurs, IP fixes |
| .50 – .99 | Réservé (extensions) |
| .100 – .199 | DHCP (postes) |
| .200 – .254 | Réservé |

## Inventaire

| Nom | Rôle | Système | IP | Services |
|-----|------|---------|----|----------|
| DC01 | Contrôleur de domaine | Windows Server 2022 | 192.168.10.10 | AD DS, DNS, DHCP |
| CLI01 | Poste client | Windows | DHCP .100–.199 | Membre du domaine |
| LNX01 | Serveur Linux | Debian 13 | 192.168.10.13 | SSH, chrony |

## Nommage

Convention « méthode du berger » (rôle + numéro, ex. `DC01`, `LNX01`, `CLI01`). Groupes : préfixe `GG_` (global) suivi du service. Domaine : `ad.econova.fr`, NetBIOS `ECONOVA`.

## Gestion des comptes

Mots de passe non versionnés. Les comptes de test sont fictifs.
