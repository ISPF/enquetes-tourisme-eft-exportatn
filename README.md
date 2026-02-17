# Export mensuel vueCube à destination d'ATN

## Description

Ce script R extrait des données de la table **`vuecube`** depuis une base de données, génère un fichier **CSV mensuel**, puis le compresse en **ZIP**.

Le processus :

1. Connexion à la base
2. Extraction filtrée par année + mois
3. Nettoyage minimal des dates
4. Export CSV (`|` séparateur)
5. Compression ZIP
6. Suppression du CSV temporaire
7. Envoi manuel du fichier ZIP sur le serveur ftp d'ATN

## Paramètres modifiables

Dans le script principal :

```r
Annee <- 2025
Mois  <- 11
```

Ces valeurs déterminent les données exportées par la requête suivante : 
```sql
select * from vuecube 
where year(datevol)=<Annee> and month(datevol)=<Mois>
```


## Fichiers générés

```
CSV : vueCube202511.csv
ZIP : vueCube202511.zip
```


## Emplacement du ZIP

| OS              | Dossier                    |
| --------------- | -------------------------- |
| Windows         | `J:/Etudes/1 - Public/ATN` |
| Linux / RServer | dossier du projet (`.`)    |


Le fichier CSV est supprimé à la fin du script


## Identifiants FTP pour ATN

Serveur : tnftp.airtahitinui.pf

Login : DSI_ISPF

Mot de passe : VJ2YIf2U

Protocol : SFTP OU FTP (préférence SFTP)

## Points d’attention

* Le lecteur `J:` doit être monté sur Windows
* `tar.exe` doit exister (Windows 10/11 OK par défaut)


