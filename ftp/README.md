# FTP Transfers


This is a non automated workload. We simply run the monitors manually and then login to ftp and then we stop the monitors. The procedure is below.



# Procedure

Start the monitors
```
../utils/./manual_exp.sh start 1 mptcp ftp_150G_baseline
```

Run the experiment
```
ftp obelix91
get file_150G

```

Wait for the experiment to complete.

Stop the monitors
```
../utils/./manual_exp.sh stop
```


After all of the experiments are one, run clean to zip things up.
```
../utils/./manual_exp.sh clean ftp_150G_baseline
```


# Config

We use the folling `~/.netrc` file:
```
machine obelix91
	login anonymous
	password "INSERT PASSWORD HERE"
```
```
