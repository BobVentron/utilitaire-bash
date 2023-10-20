#/bin/bash

if [ $# -ne 1 ]
then 
	echo "Erreur usercreation: aucun fichiers saisie"
else 
	for ligne in $(cat $1)
	do
		nom=`echo $ligne | cut -fi -d":"`
		prenom=`echo $ligne | cut -f2 -d":"`
		datenaissance=`echo $ligne | cut -f3 -d":"`
		service=`echo $ligne | cut -f4 -d":"`

		nom=`echo $nom | tr [a-z] [A-Z]`
		service=`echo $service | tr [a-z] [A-Z]`

		/usr/sbin/groupadd $service
		case $? in
			2)
				echo "groupadd : erreur de syntaxe";;
			3) 
				echo "groupadd : paramètre non valable pour l'option";;
			4)
				echo "groupadd : GID deja utilisé (et -o n'est pas utilisé)";;
			9)
 				echo "groupadd : nom de groupe deja utilisé";;
			10) 
				echo "groupadd : impossible de mettre à jour le fichier des groupes";;
		esac
		
		/usr/sbin/useradd -g $service `./loginbuild $prenom $nom`
		case $? in 
			1) 
				echo "useradd : can't update password file";;
			2)
				echo "useradd : erreur de syntaxe";;	
			3)
				echo "useradd : invalid argument to option";;
			4) 
				echo "useradd : UID already in use (and no -o)";;
			6)
				echo "useradd : specified group doesn't exist";;
			9)
				echo "useradd : username already in use";;
			10) 
				echo "useradd : can't update group file";;
			12) 
				echo "useradd : can't create home directory";;
			13) 
				echo "useradd : can't create mail spoll";;
			14)
				echo "useradd : can't update SElinux user mapping";;
		esac							
	done
fi