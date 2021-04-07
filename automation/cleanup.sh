namespace=$1

cd Spark-Benchmarking-main/yamls

echo "kubectl delete -n $namespace -f spark-submit.yaml"
kubectl delete -f spark-submit.yaml -n $namespace &
wait $!


echo "kubectl delete -n $namespace -f spark-benchmark-pvc.yaml $"
kubectl delete pvc spark-benchmark-claim -n $namespace &
wait $!
