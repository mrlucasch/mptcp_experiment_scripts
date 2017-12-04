#!/bin/bash


name=$1
tracker=$2


#ctorrent -t -u "http://10.16.3.92:6969/announce" -s ${name}.torrent $name
transmission-create -o ${name}.torrent -c "${name} Made using transmission create" -t http://${tracker}:6969/announce ${name}
