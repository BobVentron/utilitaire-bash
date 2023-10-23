#!/bin/bash

compte=0
aCopier=0
PasCopier=0
if [ $# -ne 2 ]
then
    echo "Erreur archive : il faut obligatoirement 2 paramettres"
    echo "Le premiers paramettre correspond au dossier que vous voulez copier" 
    echo "Le deuxième paramettre correspond au chemein ou vous voulez copier votre fichiers"
    echo "Ajout futur : compréssion du fichier en zip ou tar.."
else
    newFichier=`basename $1`
    archive="_archive"
    mkdir $2$newFichier$archive

    for ligne in $(ls $1)
    do 
        ((compte++))
        if [ "$ligne" = "node_modules" -o "$ligne" = "composer" -o "$ligne" = "vendor" -o "$ligne" = "cache" -o "$ligne" = "build" ]
        then
            echo "$ligne a ne pas copier" 
            ((PasCopier++))
        else
            echo "$ligne a copier"
            ((aCopier++))
            cp -r $1$ligne $2$newFichier$archive
        fi
    done
fi
echo "Sur $compte fichers $aCopier ont été copier et $PasCopier non pas été copier" 