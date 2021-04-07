namespace=$1

cd /root/Spark-Benchmarking-main/yamls

# Submitting join script command
printf "\n\n\n\nSUBMITTING JOIN SCRIPT\n\n\n\n"

echo "kubectl apply -n $namespace -f spark-submit.yaml &"
kubectl apply -f spark-submit.yaml -n $namespace &
wait $!

# Waiting for join script to finish
printf "\n\n\n\nWAITING FOR JOIN SCRIPT TO FINISH\n\n\n\n"
kubectl logs -f spark-benchmark-driver -n $namespace
wait $!