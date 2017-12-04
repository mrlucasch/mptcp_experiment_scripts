#!/bin/bash


name=$1



ctorrent -t -u "http://10.16.3.92:6969/announce" -s ${name}.torrent $name
