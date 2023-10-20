#/bin/bash/

if [ $# -ne 2 ]
then
	echo "ERREUR loginbuild: nombre arguments incorrect"
else
	prenom=`echo $1 | cut -c 1`
	nom=`echo $2 | cut -c1-7`

	login=`echo $prenom$nom | tr [A-Z] [a-z]`
	echo $login
fi