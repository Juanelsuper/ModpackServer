#!/bin/bash

#pushd "C:/Users/$(whoami)/AppData/Roaming/.minecraft/versions/ModPackServer2/mods"
pushd "~/Library/Application Support/minecraft/versions/ModPackServer2/mods"

curl "https://raw.githubusercontent.com/Juanelsuper/ModpackServer/master/modlist.txt" -o output.txt 

news=($(cat output.txt))

olds=($(ls))

echo "Server: ${#news[@]}"
echo "Client: ${#olds[@]}"

 

newraw=$(cat output.txt)
for i in ${olds[@]}; do
    if [[ $i == *.jar ]]; then
        if [[ $(echo $newraw | grep $i) == "" ]]; then
            if [[ $i != Ambient* ]]; then
                echo "Borrando $i"
                rm $i
            fi
        fi
    fi
done

oldraw=$(ls)
for i in ${news[@]}; do
    if [[ $(echo $oldraw | grep $i) == "" ]]; then
        if [[ $i != Ambient* ]]; then
            echo "Descargando $i"
            curl -O "https://raw.githubusercontent.com/Juanelsuper/ModpackServer/master/$i"
            err=$?
            if [[ $err != 0 ]]; then
                echo "Error ($err): No se pudo descargar $i."
            fi
        fi
    fi
done

sleep 2
echo "Hecho!"
rm output.txt
popd