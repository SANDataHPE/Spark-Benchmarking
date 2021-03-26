#spark-benchmark

## What does it do
This is a simple tool to see how well your spark cluster would perform under heavy loads. This is currently a WIP. As of now it will perform an inner join on 
datfarames of different sizes  and record the output.

This is how a sample run will look so far

```
Join Type      # of Left DF Rows    # of Right DF Rows    Benchmark
-----------  -------------------  --------------------  -----------
Inner Join                   100                   100    0.0676363
Inner Join                  1000                  1000    0.0570264
Inner Join                 10000                 10000    0.0856962
Inner Join                100000                100000    0.0596504
```