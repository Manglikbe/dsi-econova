<#
.SYNOPSIS
  Prend un snapshot propre d'une VM VMware Workstation avec vmrun.

.EXAMPLE
  . .\snapshots.ps1
  Snap "D:\VMs\DC01\DC01.vmx" "08-10 AD structure et teste"

.NOTES
  - Ajuster $vmrun si VMware est installé ailleurs.
  - Arrêt propre ("soft") avant le snapshot : évite les erreurs DFSR
    sur un contrôleur de domaine restauré depuis un état à chaud.
  - Ne jamais committer de chemins ou de noms propres à une machine
    qui ne devraient pas être publics.
#>

$vmrun = "C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"

function Snap {
    param(
        [Parameter(Mandatory)] [string] $Vmx,
        [Parameter(Mandatory)] [string] $Nom
    )
    if (-not (Test-Path $vmrun)) { throw "vmrun.exe introuvable : $vmrun" }
    if (-not (Test-Path $Vmx))   { throw "Fichier .vmx introuvable : $Vmx" }

    & $vmrun -T ws stop $Vmx soft
    & $vmrun -T ws snapshot $Vmx $Nom
    & $vmrun -T ws listSnapshots $Vmx
}
