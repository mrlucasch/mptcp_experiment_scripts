# Bittorrent Experiment

## Description

We use ctorrent to run our bittorrent experiments. 


## Configuration
tracker = obelix92
downloader = obelix91 
seeders = obelix92,obelix93,obelix96,obelix97,obelix98
congestion_generators = obelix94 <-> obelix95 
## Procedure

Create the torrent file. Supply the filename and the tracker hostname/ip
```
./create_tracker.sh file_150G 10.16.3.92
```
or 
```
transmission-create -o file_150G.torrent -c "file_150G Made using transmission create" -t http://10.16.3.92:6969/announce file_150G
```


Start the tracker on the tracker node:
```
./bt.sh 
```
or 
```
bttrack --port 6969 --dfile dstate
```

Start the seeder on each seed node (we use -f to skip hash checks)
```
./seed file_150G.torrent
```
or 
```
ctorrent -f file_150G.torrent
```

Start the downloader (we use -e 0 to skip seeding at the end and exit.)
```
./download file_150G.torrent
```
or 
```
time ctorrent file_150G.torrent -e 0
```

