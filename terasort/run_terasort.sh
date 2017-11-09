#!/bin/bash

MEM=40
#CORES=40
CORES=200
EXEC=5

if [ $# == 0 ]
then
echo "Please run with either:"
echo "$0 generate mptcp 20==> Generates 20g data"
echo "$0 sort mptcp ==> Runs sort"
echo "$0 validate mptcp ==> Runs validate" 
exit
fi

cd /usr/local/spark
SIZE=$3
NAME=$2
if [ $1 == "generate" ]
then
echo "Running Generate"
spark-submit --name $NAME --executor-memory ${MEM}G --total-executor-cores $CORES --class com.github.ehiggs.spark.terasort.TeraGen /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar ${SIZE}g hdfs://obelix91:9000/terasort_small
elif [ $1 == "sort" ]
then
echo "Running Sort"
#spark-submit --name $NAME --executor-memory ${MEM}G --total-executor-cores $CORES --conf "spark.reducer.maxSizeInFlight=100m" --class com.github.ehiggs.spark.terasort.TeraSort /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar hdfs://obelix90:9000/terasort_in hdfs://obelix90:9000/terasort_out
#spark-submit --name $NAME --executor-memory ${MEM}G --total-executor-cores $CORES  --class com.github.ehiggs.spark.terasort.TeraSort /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar hdfs://obelix90:9000/terasort_in hdfs://obelix90:9000/terasort_out $NAME
#spark-submit --name $NAME --num-executors $EXEC --executor-memory ${MEM}G --total-executor-cores $CORES  --class com.github.ehiggs.spark.terasort.TeraSort /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar hdfs://obelix90:9000/terasort_small hdfs://obelix90:9000/terasort_out $NAME
spark-submit --name $NAME --executor-memory ${MEM}G --class com.github.ehiggs.spark.terasort.TeraSort /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar hdfs://obelix91:9000/terasort_small hdfs://obelix91:9000/terasort_out $NAME
#spark-submit --name $NAME --executor-memory ${MEM}G --num-executors $CORES --conf "spark.reducer.maxSizeInFlight=100m" --class com.github.ehiggs.spark.terasort.TeraSort /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar hdfs://obelix90:9000/terasort_in hdfs://obelix90:9000/terasort_out
elif [ $1 == "validate" ]
then
echo "Running Validate"
spark-submit --name $NAME --executor-memory ${MEM}G --total-executor-cores $CORES --class com.github.ehiggs.spark.terasort.TeraValidate /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar hdfs://obelix91:9000/terasort_out hdfs://obelix91:9000/terasort_validate
elif [ $1 == "sort_tuned" ]
then
spark-submit --name $NAME --num-executors 14 --executor-memory 19G --executor-cores 5 --class com.github.ehiggs.spark.terasort.TeraSort /workspace/spark-terasort/target/spark-terasort-1.0-jar-with-dependencies.jar hdfs://obelix91:9000/terasort_small hdfs://obelix91:9000/terasort_out $NAME
fi
