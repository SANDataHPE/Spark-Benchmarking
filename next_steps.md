#NEXT STEPS
1) ####Fix automation scripts so we dont need wait and sleep commands. Maybe a better approach to just simply poll
2) ####Have different join types for join_table script (left, inner, outer). Also introduce different spark join optimization configurations
3) ####Apply any spark configurations for join optimizations
4) ####For cleanup phase
    * Perform mapr ticket deletion
5) ####Set a TTL for mapr ticket generation
6) ####Automate installation of requirements.txt on driver pod
7) ####Automate passing in arguments into yaml files 
8) ####Verify that this will work on data fabric clusters and embedded data fabric clusters
9) ####Automate mapr ticket generation phase
10) ####Configure K8 master so it can clone github repositories or provision S3 buckets so it can store source code