# Équivalent PowerShell de la structure d'annuaire de DC01.
# ATTENTION : la structure réelle a été créée via l'interface graphique ;
# ce script est une référence reproductible, non exécuté tel quel dans le labo.
# Aucun mot de passe n'est écrit ici : il est saisi à l'exécution.

$base   = "DC=ad,DC=econova,DC=fr"
$racine = "OU=econova,$base"

# OU, protégées contre la suppression accidentelle
New-ADOrganizationalUnit -Name "econova" -Path $base -ProtectedFromAccidentalDeletion $true
foreach ($n in "Utilisateurs", "Groupes", "Ordinateurs") {
    New-ADOrganizationalUnit -Name $n -Path $racine -ProtectedFromAccidentalDeletion $true
}
foreach ($n in "postes", "serveurs") {
    New-ADOrganizationalUnit -Name $n -Path "OU=Ordinateurs,$racine" -ProtectedFromAccidentalDeletion $true
}

# Un groupe de sécurité global par service
foreach ($g in "GG_Compta", "GG_RH", "GG_IT") {
    New-ADGroup -Name $g -GroupScope Global -GroupCategory Security -Path "OU=Groupes,$racine"
}

# Exemple de compte de test (convention de connexion : prenom.nom)
New-ADUser -Name "Prenom Nom" -SamAccountName "prenom.nom" `
    -UserPrincipalName "prenom.nom@ad.econova.fr" `
    -Path "OU=Utilisateurs,$racine" `
    -AccountPassword (Read-Host "Mot de passe provisoire" -AsSecureString) `
    -ChangePasswordAtLogon $true -Enabled $true
Add-ADGroupMember -Identity "GG_IT" -Members "prenom.nom"

# Déplacer un poste du conteneur Computers vers l'OU des postes
# Get-ADComputer "CLI01" | Move-ADObject -TargetPath "OU=postes,OU=Ordinateurs,$racine"
