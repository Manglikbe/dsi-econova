# Procès-verbal de recette — Projet 1

Chaque test est relié à une exigence du [cahier des charges](../README.md). « Attendu » est le critère ; la colonne « Preuve » renvoie à la capture.

| Test | Exigence | Commande (machine) | Attendu | Résultat | Preuve |
|------|----------|--------------------|---------|----------|--------|
| T01 | EX-01 | `ping 192.168.10.10` (CLI01, LNX01) | Réponses | OK | — |
| T02 | EX-02 | `ipconfig /all` (CLI01) | IP dans .100–.199 | OK | `02` |
| T03 | EX-03 | `nltest /dsgetdc:ad.econova.fr` (DC01) | DC01 renvoyé | OK | `01` |
| T04 | EX-04 | `getent hosts dc01.ad.econova.fr`, `nslookup` (LNX01) | 192.168.10.10 | OK | `10` |
| T05 | EX-05 | `ipconfig /all` (CLI01) | Routeur .2, DNS .10, suffixe `ad.econova.fr` | OK | `02` |
| T06 | EX-06 | OU des postes (console AD) | CLI01 présent | OK | `12` |
| T07 | EX-07 | `Get-ADOrganizationalUnit -Filter *` | Arborescence mixte | OK | `03` |
| T08 | EX-07 | `Get-ADGroupMember -Identity GG_IT` | Membres attendus | OK | `04` |
| T09 | EX-07 | `whoami /groups` (session standard) | Groupe GG_* attendu, aucun groupe d'administration | OK, écart « Utilisateurs du domaine » absent (journal) | `05` |
| T10 | EX-07 | `net user <compte> /domain` | Appartenances correctes | OK | `06` |
| T11 | EX-08 | `net share` (DC01) | SYSVOL et NETLOGON | OK | `07` |
| T12 | EX-08 | `dcdiag` (DC01) | Aucun échec | **Échec DFSREvent initial, à reconfirmer après 24 h** | `08` |
| T13 | EX-09 | `chronyc tracking` (LNX01) | Heure synchronisée | OK | — |
| T14 | EX-09 | `ip a` (LNX01) | 192.168.10.13/24, carte NAT inactive | OK | `10`, `11` |
| T15 | EX-10 | `vmrun listSnapshots` | Snapshot présent par VM | OK | — |

## Conclusion

Socle opérationnel. **Réserve** : T12 reste ouvert jusqu'à un `dcdiag` propre après 24 h de fonctionnement ; il sera daté et complété ici.

| Date de recette | Recetteur |
|-----------------|-----------|
| [à renseigner] | Manglikbè Abiguime |

> Les tests sans capture (T01, T13, T15) ont été constatés mais non archivés : ajouter une capture si l'on veut une preuve complète.
