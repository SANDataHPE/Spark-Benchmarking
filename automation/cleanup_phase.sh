namespace=$1

kubectl delete -f /root/Spark-Benchmarking-main/yamls/spark-benchmark-join.yaml -n $namespace &
kubectl delete -f /root/Spark-Benchmarking-main/yamls/spark-benchmark-terragen.yaml -n $namespace &
wait $!


kubectl delete -f /root/Spark-Benchmarking-main/yamls/spark-benchmark-temp-pod.yaml -n $namespace &
kubectl delete -f /root/Spark-Benchmarking-main/yamls/spark-benchmark-pvc.yaml -n $namespace &
wait $!