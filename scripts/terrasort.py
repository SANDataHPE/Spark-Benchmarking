from pyspark.sql import SparkSession
from uuid import uuid4
import random
from argparse import ArgumentParser
import os
from utility import time_it


@time_it
def perform_sort(rdd_):
    sorted_rdd = rdd_.sortBy(lambda element: int(element))


@time_it
def perform_optimized_aggregation(rdd_):
    rdd_.map(lambda random_number: (random_number, 1)).reduceByKey(lambda x, y: (x + y))


@time_it
def perform_unoptimized_aggregation(rdd_):
    rdd_.map(lambda random_number: (random_number, 1)).groupByKey().map(lambda x, y: (x + y))


def main():
    rdd_ = spark.sparkContext.textFile("file:///spark-benchmark-mount/terragen-files/*")
    perform_sort(rdd_)
    perform_optimized_aggregation(rdd_)
    perform_unoptimized_aggregation(rdd_)


if __name__ == '__main__':
    spark = SparkSession.builder.appName("Spark Terragen").getOrCreate()
    main()

