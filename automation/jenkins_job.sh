namespace=$1

./setup_phase.sh $namespace
./submit_spark_jobs_phase.sh $namespace
./cleanup_phase.sh $namespace
