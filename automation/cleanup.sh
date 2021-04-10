namespace=$1

kubectl delete -f /root/Spark-Benchmarking-main/yamls/spark-submit.yaml -n $namespace &
wait $!

kubectl delete pvc spark-benchmark-claim -n $namespace &
wait $!