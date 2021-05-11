#/bin/bash

# generamos un directorio que contiene archivos con el nombre de los paises y dentro de los archivos las ip que han atacado
mkdir -p ./paises_db.d
rm -f ./paises_db.d/*
echo "Generamos directorio con los paises"
while read p;
	do
    ip=$(echo $p | cut -d'|' -f1)
    p=$(echo $p | cut -d'|' -f4)
    touch "./paises_db.d/$p"
		echo $ip >> "./paises_db.d/$p"
	done <banned.log

#ordenamos las ip de cada pais
echo "Ordenamos las IP de cada pais"
find ./paises_db.d -type f -exec sort -o {} {} \;

# generamos el fichero paises.log donde tenemos el pais y el numero de ataques
mkdir -p paises_ip.d
rm ./paises_ip.d/*
ls ./paises_db.d > paises.log
linia=0
while read p;
do
  linia=$((linia+1))
  num=$(cat ./paises_db.d/$p | wc -l)
  sed -e "${linia}s/$/|$num/" -i paises.log
  cat ./paises_db.d/$p | uniq > ./paises_ip.d/$p
done < paises.log
cat paises.log | awk 'BEGIN{FS="|"}{print $2 "|"$1}' > paisses
sort -g -r -o paises.log paisses
rm -f paisses
