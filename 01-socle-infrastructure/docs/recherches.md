# Notions étudiées — Projet 1

## Réseau et adressage
- **Host-only vs NAT** : host-only isole les VM de l'extérieur ; le NAT n'a servi que temporairement pour installer des paquets sur Debian.
- **Plan d'adressage** : séparer plage fixe (serveurs) et plage dynamique évite les conflits.

## Active Directory
- **Forêt, domaine, contrôleur de domaine** : le premier DC crée la forêt.
- **DNS intégré** : l'AD s'appuie sur des enregistrements SRV pour que les clients trouvent le DC.
- **SYSVOL / NETLOGON** : partages répliqués (DFSR) contenant stratégies et scripts.
- **OU vs groupes** : l'OU structure et délègue ; le groupe porte les droits.
- **Stratégie AGDLP / groupes globaux** : droits attribués à des groupes, jamais directement aux utilisateurs.
- **Moindre privilège** : un utilisateur courant ne doit appartenir à aucun groupe d'administration (vérifié par `whoami /groups`).

## DHCP
- Étendue, plage, durée de bail, options (routeur, DNS, domaine) ; autorisation du serveur dans l'AD.
- Réservation : associe une IP à une adresse MAC ; jugée inutile pour le client ici.

## Diagnostic
- `nltest /dsgetdc` : quel DC répond à un client.
- `dcdiag` : santé globale d'un DC ; ses tests peuvent échouer sur des événements d'initialisation sans que le service soit défaillant.
- Journal DFSR : événements d'initialisation vs erreurs persistantes.

## Linux
- `ifupdown` : configuration réseau statique dans `/etc/network/interfaces`.
- Sans `resolvconf`, `/etc/resolv.conf` est un fichier simple.
- `chrony` : synchronisation de l'heure ; indispensable avec Kerberos (tolérance de 5 minutes).

## Virtualisation
- Snapshots VMware en ligne de commande avec `vmrun` ; arrêter proprement avant de capturer.

## À approfondir
- Cause de l'absence de « Utilisateurs du domaine » dans `whoami /groups`.
- Interprétation fine des événements DFSR 1355.
