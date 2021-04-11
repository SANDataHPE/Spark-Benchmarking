from pyspark.sql import SparkSession
from uuid import uuid4
import random
from argparse import ArgumentParser
import os

def perform_sort():
    rdd_ = spark.sparkContext.textFile("file:///spark-benchmark-mount/terragen-files/*")
    print(f"the number of partitions in rdd {rdd_.getNumPartitions()}")
    print(f"RDD is: {rdd_.collect()}")
    print("\n\n\n\n\n")
    sorted_rdd = rdd_.sortBy(lambda element: int(element))
    print(f"the number of partitions in sorted rdd is {sorted_rdd.getNumPartitions()}")
    print(f"RDD is: {sorted_rdd_.collect()}")


def main():
    perform_sort()


if __name__ == '__main__':
    spark = SparkSession.builder.appName("Spark Terragen").getOrCreate()
    main()

