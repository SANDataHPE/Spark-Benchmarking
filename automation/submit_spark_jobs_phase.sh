namespace=$1

# Submitting join script command
printf "\n\n\n\nSUBMITTING JOIN SCRIPT\n\n\n\n"
kubectl apply -f /root/Spark-Benchmarking-main/yamls/spark-benchmark-join.yaml -n $namespace &
wait $!


# Submitting terragen script
printf "\n\n\n\nSUBMITTING TERRAGEN SCRIPT\n\n\n\n"
kubectl apply -f /root/Spark-Benchmarking-main/yamls/spark-benchmark-terragen.yaml -n $namespace &
wait $!


# Submitting terrasort script
printf "\n\n\n\nSUBMITTING TERRAGEN SCRIPT\n\n\n\n"
kubectl apply -f /root/Spark-Benchmarking-main/yamls/spark-benchmark-terrasort.yaml -n $namespace &
wait $!

#TODO: Find a way to properly poll any kubetl job
# Waiting for join script to finish
printf "\n\n\n\nWAITING FOR JOIN SCRIPT TO FINISH\n\n\n\n"
kubectl logs -f spark-benchmark-driver -n $namespace
wait $!
