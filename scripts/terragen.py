from pyspark.sql import SparkSession
from uuid import uuid4
import random
from argparse import ArgumentParser
import os

def configure_argparse():
    parser = ArgumentParser()
    parser.add_argument("rows_of_file", type=int)
    return list(vars(parser.parse_args()).values())


def generate_n_row_file(rows_per_file, number_of_executors):
    while number_of_executors:
        rows_per_file_tmp = rows_per_file
        with open(f"/spark-benchmark-mount/terragen-files/{uuid4()}.txt", "w") as file_:
            while rows_per_file_tmp:
                file_.write(str(random.randint(1, 10)) + "\n")
                rows_per_file_tmp -= 1
        number_of_executors -=1


def main():
    rows_per_file = configure_argparse()[0]
    print(f"rows per file is {rows_per_file}")
    number_of_executors = int(spark.sparkContext.getConf().get("spark.executor.instances"))
    print(f"number of executors is {number_of_executors}")
    generate_n_row_file(rows_per_file, number_of_executors)


if __name__ == '__main__':
    spark = SparkSession.builder.appName("Spark Terragen").getOrCreate()
    main()

