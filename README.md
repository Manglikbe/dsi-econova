# DSI Econova — système d'information d'une PME des énergies renouvelables

**Français** | [English version below](#english)

Econova est une entreprise **fictive** de 30 salariés, spécialisée dans les énergies renouvelables, répartie sur deux sites : la direction et une cellule sur le site industriel de fabrication de panneaux photovoltaïques. Ce dépôt rassemble les 6 projets qui construisent, sécurisent et supervisent son système d'information, de la simple mise en place jusqu'au monitoring.

> Tout est réalisé dans un **laboratoire virtualisé** (VMware), isolé de tout réseau de production. Aucun mot de passe, clé ou donnée sensible n'est publié ici.

## Avancement

| # | Projet | Compétences | Statut |
|---|--------|-------------|--------|
| 1 | [Socle d'infrastructure](01-socle-infrastructure/) | Virtualisation, plan d'adressage, Active Directory, DNS, DHCP, client Windows, serveur Debian | Terminé (1 point à reconfirmer, voir la recette) |
| 2 | Réseau et segmentation | VLAN, routage, pare-feu, matrice de flux | À venir |
| 3 | Services et identités | Stratégies de groupe, partages, droits d'accès | À venir |
| 4 | Sauvegarde et continuité | Stratégie 3-2-1, tests de restauration, PRA | À venir |
| 5 | Sécurisation et durcissement | Hardening, MFA, VPN, gestion des vulnérabilités | À venir |
| 6 | Supervision et monitoring | Supervision, journalisation, alertes, scénarios de crise | À venir |

## Environnement

- Virtualisation : VMware Workstation, réseau virtuel isolé (host-only, `192.168.10.0/24`)
- Systèmes : Windows Server 2022, poste client Windows, Debian 13
- Domaine de laboratoire : `ad.econova.fr` (NetBIOS `ECONOVA`)

## Structure d'un projet

```
NN-nom-du-projet/
├─ README.md        Cahier des charges et résultat
├─ JOURNAL.md       Incidents rencontrés et décisions prises
├─ docs/
│  ├─ installation.md   Procédure reproductible
│  ├─ validation.md     Procès-verbal de recette
│  ├─ recherches.md     Notions étudiées
│  └─ inventaire.md     Document spécifique au projet
├─ conf/            Fichiers de configuration versionnés
├─ captures/        Captures d'écran nettoyées
└─ carrousel/       Support de présentation (PDF)
```

## Principes de travail

- **Cahier des charges** : des exigences numérotées (EX-01, EX-02…), chacune avec un critère de validation exécutable.
- **Recette** : chaque exigence est vérifiée par une commande dont le résultat est consigné et relié à une capture.
- **Installation reproductible** : la procédure est rédigée pour pouvoir reconstruire le projet à partir de la documentation seule.
- **Journal de bord** : les incidents et les décisions sont notés au fil de l'eau, y compris ce qui reste inexpliqué.
- **Historique** : un commit par étape logique (`projet-0X: description`), un tag `projet-X` en fin de projet.

## À propos

Projets réalisés par Manglikbè Abiguime dans le cadre d'un parcours d'administration systèmes, réseaux et cybersécurité. [LinkedIn](https://www.linkedin.com/in/manglikb%C3%A8abiguime/)

Aucune licence n'est définie : tous droits réservés, le contenu est publié pour être consulté.

---

<a id="english"></a>

# Econova IT department — information system of a renewable-energy SME

Econova is a **fictional** company of 30 employees in renewable energy, spread over two sites: the head office and a unit on the industrial site producing photovoltaic panels. This repository gathers the 6 projects that build, secure and monitor its information system, from basic setup to monitoring.

> Everything is built in a **virtualized lab** (VMware), isolated from any production network. No password, key or sensitive data is published here.

## Progress

| # | Project | Skills | Status |
|---|---------|--------|--------|
| 1 | [Infrastructure foundation](01-socle-infrastructure/) | Virtualization, addressing plan, Active Directory, DNS, DHCP, Windows client, Debian server | Done (1 point to reconfirm, see the acceptance report) |
| 2 | Network and segmentation | VLANs, routing, firewall, flow matrix | Upcoming |
| 3 | Services and identities | Group Policy, file shares, access control | Upcoming |
| 4 | Backup and continuity | 3-2-1 strategy, restore tests, DRP | Upcoming |
| 5 | Hardening and security | Hardening, MFA, VPN, vulnerability management | Upcoming |
| 6 | Monitoring | Supervision, logging, alerting, crisis scenarios | Upcoming |

## Environment

- Virtualization: VMware Workstation, isolated virtual network (host-only, `192.168.10.0/24`)
- Systems: Windows Server 2022, Windows client, Debian 13
- Lab domain: `ad.econova.fr` (NetBIOS `ECONOVA`)

## Project structure

Each project follows the layout shown above: `README.md` (requirements and result), `JOURNAL.md` (incidents and decisions), `docs/` (installation, acceptance report, study notes, project-specific document), `conf/`, `captures/`, `carrousel/`.

## Working principles

- **Requirements**: numbered (EX-01, EX-02…), each with an executable validation criterion.
- **Acceptance**: each requirement is checked by a command whose output is recorded and linked to a screenshot.
- **Reproducible installation**: written so the project can be rebuilt from the documentation alone.
- **Logbook**: incidents and decisions are recorded as they happen, including what remains unexplained.
- **History**: one commit per logical step (`projet-0X: description`), a `projet-X` tag at the end of each project.

## About

Projects carried out by Manglikbè Abiguime as part of a systems, network and cybersecurity administration path. [LinkedIn](https://www.linkedin.com/in/manglikb%C3%A8abiguime/)

No licence is defined: all rights reserved, the content is published for viewing.
