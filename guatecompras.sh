#!/bin/bash

#Doesnt work for various pages, cURL only returns static content, needed headless-browser to exec the __doPostBAck() on n page

# TODO set up crontab on server execute every day

get_NGOs(){

STR_INPUT=$1

echo "fetching data"

# TODO function for any 'Keyword'

curl -o out.txt "http://www.guatecompras.gt/concursos/detallePorSubModConcuros.aspx?Ent=-1&Tep=-1&Te=-1&Uc=-1&Est=-1&DType=-1&NOG=&SNIP=-1&TC=-1&CAT=-1&Desc=${STR_INPUT}&MOD=-1&TRO=-1&typeS=1"

echo "http://www.guatecompras.gt/concursos/detallePorSubModConcuros.aspx?Ent=-1&Tep=-1&Te=-1&Uc=-1&Est=-1&DType=-1&NOG=&SNIP=-1&TC=-1&CAT=-1&Desc="$1"&MOD=-1&TRO=-1&typeS=1"

echo "search for NGOs"

grep -ri "NOG (Número de Operación Guatecompras)" | grep -o -P '(?<=<b>).*(?=</b></span>)' >> lines.txt

echo $(wc -l lines.txt) " matches for " "$1"

#SIZE_NGOS=$(wc -l lines.txt)

echo "valid URLs for the newest contest"

awk '$1="http://www.guatecompras.gt/concursos/consultaConcurso.aspx?nog="$1"&o=5"' < lines.txt >> NGOs.txt

echo "open first" ## check is it a valid URL
#firefox $(head -n 1 NGOs.txt) &

rm out.txt lines.txt

}

get_NGOs "HOSPITAL%20ROOSEVELT"

get_NGOs "HOSPITAL"

get_NGOs "COVID%2019"
