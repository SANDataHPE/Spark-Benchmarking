namespace=$1

# Deleting the code base in case it exists
printf "\n\n\n\nDELETING DIRECTORIES \n\n\n\n\n"
rm -rf Spark-Benchmarking-main
rm -rf main.zip

# Copy files phase
printf "\n\n\n\nCOPYING REPO TO PWD\n\n\n\n\n"
wget https://github.com/sandatasystem/Spark-Benchmarking/archive/refs/heads/main.zip &
wait $!

# Unzipping main.zip
unzip main.zip &
wait $!
cd Spark-Benchmarking-main/yamls

sleep 2

# Creating a PVC
printf "\n\n\n\nCREATING PVC\n\n\n\n\n"
kubectl apply -f spark-benchmark-pvc.yaml -n $namespace &
wait $!
sleep 15


# Creating a temp pod
printf "\n\n\n\nCREATING TEMP POD\n\n\n\n"
kubectl apply -f spark-benchmark-temp-pod.yaml -n $namespace &
wait $!
sleep 15

# Copying join_table.py to PVC
printf "\n\n\n\nCOPYING SCRIPTS TO PVC\n\n\n\n"
echo "kubectl cp /root/Spark-Benchmarking-main/join_table.py t01/spark-benchmark-temp-pod:/spark-benchmark-mount/"
kubectl cp /root/Spark-Benchmarking-main/join_table.py  t01/spark-benchmark-temp-pod:/spark-benchmark-mount/ &
wait $!
sleep 12

exit 0

# Delete utility pod
printf "\n\n\n\nDELETING UTILITY POD\n\n\n\n"
kubectl delete -f spark-benchmark-temp-pod.yaml -n $namespace &
wait $!