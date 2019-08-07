#!/bin/bash
#sin

#view
RED=$(tput setaf 1) 
GREEN=$(tput setaf 2) 
CYAN=$(tput setaf 6) 
WHITE=$(tput setaf 7) 

begin=$(date +"%s")


echo "![Hitomish]!"

#get
read -p "${WHITE}code: " kode
echo -e "\n"
read -p "${WHITE}${kode} Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo -e "reading source for /${GREEN}$kode ..
${WHITE}"

wget -O ${kode}.html https://hitomi.la/galleries/${kode}.html;

#do
mkdir $kode
cat ${kode}.html | grep 'tn.hitomi.la/smalltn/' | sed 's/\?.*//' | sed 's/smalltn/webp/' | sed 's/.jpg.jpg/.jpg.webp/' | sed 's/tn/ba/' | sed "s/'//" | sed "s/',//" > ${kode}/links.txt; 
cd $kode;
wget -i links.txt; # --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" if necessary

#webp conv if necessary
find ./ -name "*.webp" -exec dwebp {} -o {}.png \;
find . -name "*.webp" -type f -delete;

#length
termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "${WHITE}$(($difftimelps / 60)) minutes and $(($difftimelps % 60)) sec. elapsed ${RED}hitomish"

#1090597