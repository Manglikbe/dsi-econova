# Projet 1 — Socle d'infrastructure

## Contexte

Econova est une PME fictive de 30 salariés (énergies renouvelables, deux sites). Avant toute segmentation ou sécurisation, il faut un socle : un réseau de laboratoire isolé, un annuaire, la résolution de noms, l'attribution d'adresses, un poste client et un serveur Linux.

## Périmètre

| Machine | Rôle | Système | Adresse |
|---------|------|---------|---------|
| DC01 | Contrôleur de domaine, DNS, DHCP | Windows Server 2022 | 192.168.10.10 (fixe) |
| CLI01 | Poste client | Windows | DHCP (plage .100–.199) |
| LNX01 | Serveur Linux | Debian 13 | 192.168.10.13 (fixe) |
| (futur pare-feu) | Passerelle | — | 192.168.10.2 (réservée, projet 2) |

Réseau : VMware host-only `VMnet2`, `192.168.10.0/24`, DHCP de VMware désactivé. Domaine : `ad.econova.fr`, NetBIOS `ECONOVA`.

## Cahier des charges

| Réf. | Exigence | Critère de validation |
|------|----------|-----------------------|
| EX-01 | Réseau virtuel isolé, DHCP VMware désactivé | Les 3 VM communiquent entre elles ; seul DC01 répond aux demandes DHCP |
| EX-02 | Plan d'adressage : .2 passerelle, .10–.49 serveurs fixes, .100–.199 DHCP | Adresses de DC01 et LNX01 hors plage DHCP ; CLI01 dans la plage |
| EX-03 | DC01 nommé avant la promotion ; forêt `ad.econova.fr` | `nltest /dsgetdc:ad.econova.fr` renvoie DC01 |
| EX-04 | DNS intégré à l'AD, résolution du domaine depuis tous les systèmes | `nslookup ad.econova.fr` sur CLI01 et LNX01 |
| EX-05 | DHCP : étendue .100–.199, routeur .2, DNS .10, domaine `ad.econova.fr` | `ipconfig /all` sur CLI01 : bail et options conformes |
| EX-06 | CLI01 joint au domaine et rangé dans l'OU des postes | `Get-ADComputer CLI01` : chemin dans l'OU des postes |
| EX-07 | OU mixte (utilisateurs, ordinateurs, groupes), groupes globaux `GG_*`, moindre privilège | `Get-ADOrganizationalUnit`, `Get-ADGroupMember`, `whoami /groups` sur une session standard |
| EX-08 | SYSVOL et NETLOGON partagés, réplication DFSR saine | `net share` ; `dcdiag` sans échec ; journal DFSR |
| EX-09 | LNX01 en IP fixe, résolution du domaine, heure synchronisée | `getent hosts dc01.ad.econova.fr`, `ping`, `chronyc tracking` |
| EX-10 | Snapshots de référence de chaque VM | `vmrun listSnapshots` |

## Résultat

| Réf. | Résultat | Preuve |
|------|----------|--------|
| EX-01 | Conforme | voir [validation](docs/validation.md) |
| EX-02 | Conforme | [inventaire](docs/inventaire.md) |
| EX-03 | Conforme | `captures/01-nltest-dsgetdc.png` |
| EX-04 | Conforme | `captures/10-lnx01-resolution-dns.png` |
| EX-05 | Conforme | `captures/02-client-bail-dhcp.png` |
| EX-06 | Conforme | `captures/12-cli01-dans-ou-postes.png` |
| EX-07 | Conforme, 1 écart observé (voir journal) | `captures/03` à `06` |
| EX-08 | **Partiel** : partages conformes, `dcdiag` DFSR à reconfirmer après 24 h | `captures/07`, `08` |
| EX-09 | Conforme | `captures/10`, `11` |
| EX-10 | Conforme | `conf/hote-vmware/snapshots.ps1` |

## Limites connues (traitées dans les projets suivants)

- La règle de pare-feu Windows autorisant l'ICMP est ouverte : à restreindre au projet 5.
- La stratégie de mots de passe est celle par défaut (42 jours) : à durcir au projet 5.
- Le routage et le pare-feu (passerelle .2) arrivent au projet 2.

## Contenu du dossier

- [JOURNAL.md](JOURNAL.md) — incidents et décisions
- [docs/installation.md](docs/installation.md) — procédure reproductible
- [docs/validation.md](docs/validation.md) — procès-verbal de recette
- [docs/recherches.md](docs/recherches.md) — notions étudiées
- [docs/inventaire.md](docs/inventaire.md) — plan d'adressage, nommage, inventaire
- [conf/](conf/) — fichiers de configuration et scripts de référence
- [carrousel/](carrousel/projet-01-carrousel.pdf) — support de présentation
