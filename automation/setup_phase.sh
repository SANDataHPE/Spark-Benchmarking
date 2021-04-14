namespace=$1

# Creating a PVC
printf "\n\n\n\nCREATING PVC\n\n\n\n\n"
export STORAGE_CLASS_NAME="df01"
j2 $HOME/Spark-Benchmarking/yamls/spark-benchmark-terragen.yaml > /tmp/spark-benchmark-pvc.yaml
kubectl apply -f $HOME/spark-benchmark-pvc.yaml -n $namespace

# Creating a temp pod
printf "\n\n\n\nCREATING TEMP POD\n\n\n\n"
kubectl apply -f $HOME/Spark-Benchmarking/yamls/spark-benchmark-temp-pod.yaml -n $namespace
wait $!
sleep 15

# Copying all python scripts to PVC
printf "\n\n\n\nCOPYING SCRIPTS TO PVC\n\n\n\n"
kubectl cp -r $HOME/Spark-Benchmarking/scripts t01/spark-benchmark-temp-pod:/spark-benchmark-mount/ &

# Create terragen-files directory and make sure it has permissions for spark terragen script to write to 
kubectl exec -n t01 -it spark-benchmark-temp-pod -- mkdir -p spark-benchmark-mount/terragen-files
#TODO: Provide correct permissions on this directory instead of using 777
kubectl exec -n t01 -it spark-benchmark-temp-pod -- chmod -R 777 spark-benchmark-mount/terragen-files
wait $!
sleep 12

# Delete utility pod
printf "\n\n\n\nDELETING UTILITY POD\n\n\n\n"
kubectl delete -f $HOME/Spark-Benchmarking-main/yamls/spark-benchmark-temp-pod.yaml -n $namespace &
wait $!
