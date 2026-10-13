# Journal — Projet 1

Incidents rencontrés et décisions prises, dans l'ordre où ils sont apparus.

## Décisions

| # | Décision | Alternative écartée | Raison |
|---|----------|---------------------|--------|
| D1 | Réseau host-only `192.168.10.0/24`, DHCP VMware désactivé | NAT | Isolation du laboratoire ; un seul serveur DHCP maîtrisé (DC01) |
| D2 | Passerelle réservée en `.2` | `.1` | `.1` est utilisée par l'hôte VMware sur le réseau virtuel ; `.2` reste cohérente avec le futur pare-feu |
| D3 | Plages : serveurs fixes .10–.49, DHCP .100–.199 | Tout en DHCP | Les serveurs gardent une adresse stable |
| D4 | Domaine `ad.econova.fr` | `econova.lan` | Choix final de l'étudiant : nom de domaine réel, plus proche d'un cas d'entreprise |
| D5 | NetBIOS `ECONOVA` | — | Nom court dérivé de l'entreprise |
| D6 | OU « mixte » (utilisateurs, ordinateurs, groupes) | Une OU par service | Lisibilité pour une PME de 30 personnes |
| D7 | Groupes globaux `GG_*` et droits donnés aux groupes | Droits par utilisateur | Moindre privilège, gestion simplifiée |
| D8 | LNX01 en `.13` | `.11` prévu | Adresse déjà prise sur la VM ; inventaire mis à jour |
| D9 | Client en DHCP sans réservation | Réservation d'une IP fixe | Non nécessaire ici ; le poste est identifié par son nom |

## Incidents

### I1 — Promotion AD refusée : mot de passe administrateur vide
- **Symptôme** : l'assistant AD DS échoue au contrôle des prérequis.
- **Cause** : le compte Administrateur local n'avait pas de mot de passe.
- **Correction** : `net user Administrateur *`, puis relance de l'assistant.

### I2 — Nom de machine aléatoire
- **Symptôme** : le serveur s'appelait `WIN-7UJAKUKRHM9`.
- **Correction** : renommé `DC01` **avant** la promotion (renommer après est possible mais plus délicat).

### I3 — Erreur de syntaxe PowerShell
- **Symptôme** : `Get-ADGroupMember -Identify GG_IT | jamy.fox` échoue.
- **Cause** : paramètre `-Identity` mal orthographié et pipe vers un nom au lieu d'une commande.
- **Correction** : `Get-ADGroupMember -Identity GG_IT | Select Name`.

### I4 — `dcdiag` : test DFSREvent en échec
- **Symptôme** : 4 événements DFSR (dont l'erreur 1355) dans le journal.
- **Analyse** : ils datent de l'initialisation, avant que le domaine n'existe. Hypothèse d'une erreur transitoire.
- **Vérification prévue** : état de réplication via WMI (`dfsrreplicatedfolderinfo`) et nouveau `dcdiag` après 24 h.
- **Statut** : **à reconfirmer** — non clos tant que le second `dcdiag` n'est pas vert.

### I5 — Accès Internet de Debian
- **Symptôme** : pas de paquets, ajout d'une carte NAT sans effet.
- **Causes** : pas de `sudo` ni de `dhclient` sur l'installation minimale ; dépôt `cdrom` actif dans `sources.list`.
- **Correction** : travail en `root` (`su`), IP NAT manuelle `192.168.88.50/24` via `.88.2`, dépôt `cdrom` commenté, dépôts `deb.debian.org` (trixie).
- **Retour à l'état propre** : carte NAT désactivée à la fin ; fichiers dans `conf/lnx01/`.

### I6 — DNS de Debian non persistant
- **Symptôme** : `/etc/resolv.conf` écrasé.
- **Cause** : pas de `resolvconf` avec `ifupdown`.
- **Correction** : fichier statique (`search ad.econova.fr`, `nameserver 192.168.10.10`) et `dns-nameservers` dans `interfaces`.
- **Erreur de ma part corrigée en cours de route** : j'avais affirmé qu'un redémarrage restaurerait le fichier ; faux dans cette configuration.

## Observations non résolues

- **`whoami /groups`** n'affiche pas « Utilisateurs du domaine » alors que le groupe est bien présent dans l'AD. Cause non identifiée, **aucun impact constaté sur les droits**. À réexaminer si cela réapparaît.
- Les captures d'origine montrent des noms d'utilisateurs de test (fictifs) ; le nom de session est flouté sur la capture `05`.
- La capture DHCP (`02`) montre le nom `DESKTOP-FEPQSRE` : le poste a été renommé `CLI01` ensuite.

## Reporté aux projets suivants

- ICMP ouvert sur Windows et mots de passe par défaut → projet 5.
- Passerelle `.2` et filtrage → projet 2.
