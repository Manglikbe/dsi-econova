# Installation — procédure reproductible

Objectif : reconstruire le socle du projet 1 à partir de ce document. Les mots de passe ne figurent pas ici : ils sont saisis à l'exécution.

## 0. Prérequis

- VMware Workstation, ISO Windows Server 2022, Windows client, Debian 13.
- Hôte utilisé pour le test : 16 Go de RAM, AMD Ryzen 5.
- Ressources suggérées : DC01 (2 vCPU, 4 Go), CLI01 (2 vCPU, 4 Go), LNX01 (1 vCPU, 1 Go). *À ajuster selon l'hôte.*

## 1. Réseau virtuel

1. VMware → Virtual Network Editor → créer `VMnet2`, type host-only.
2. Sous-réseau `192.168.10.0` / `255.255.255.0`.
3. **Décocher** « Use local DHCP service ».
4. Connecter chaque VM à `VMnet2`.

## 2. DC01 (Windows Server 2022)

1. Installer le système, fixer le mot de passe Administrateur (`net user Administrateur *`).
2. Renommer en `DC01` puis redémarrer.
3. IP fixe : `192.168.10.10/24`, passerelle `192.168.10.2`, DNS `192.168.10.10`.
4. Installer AD DS et promouvoir en nouvelle forêt `ad.econova.fr` (NetBIOS `ECONOVA`), DNS intégré. Équivalent script : `conf/dc01/annuaire.ps1`.
5. Installer DHCP, autoriser le serveur dans l'AD, créer l'étendue `.100–.199`, options routeur `.2`, DNS `.10`, domaine `ad.econova.fr`. Équivalent : `conf/dc01/dhcp.ps1`.
6. Créer les OU (mixte : utilisateurs, ordinateurs, groupes), les groupes `GG_*` et les comptes de test ; ajouter les comptes aux groupes.

## 3. CLI01 (client Windows)

1. Réseau en DHCP, vérifier le bail (`ipconfig /all`).
2. Joindre le domaine `ad.econova.fr`, renommer `CLI01`.
3. Déplacer l'objet ordinateur dans l'OU des postes.

## 4. LNX01 (Debian 13)

1. Installation minimale avec serveur SSH.
2. IP fixe : copier `conf/lnx01/interfaces` vers `/etc/network/interfaces`, et `conf/lnx01/resolv.conf` vers `/etc/resolv.conf`.
3. Accès Internet **temporaire** (carte NAT, adresse manuelle) : suivre `conf/lnx01/acces-internet-temporaire.sh`, puis désactiver la carte.
4. Dépôts : `conf/lnx01/sources.list`, puis `apt update`.
5. Paquets : `chrony openssh-server dnsutils`.

## 5. Snapshots de référence

Exécuter `conf/hote-vmware/snapshots.ps1` (adapter les chemins `.vmx`). Les VM sont arrêtées proprement avant chaque snapshot.

## 6. Contrôle

Dérouler [validation.md](validation.md). Le socle est reconstruit quand tous les tests sont verts.

> **Statut du test de reconstruction** : cette procédure a été rédigée à partir de la réalisation d'origine ; elle n'a **pas encore été rejouée** de bout en bout. À faire avant de la déclarer reproductible.
