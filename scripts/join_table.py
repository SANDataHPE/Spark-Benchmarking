import random
from pyspark.sql import SparkSession
from pyspark.sql.types import StringType, StructField, StructType
import time
from argparse import ArgumentParser


def time_it(func):
    """
    Utility decorator used to time any operations
    """
    def print_metrics(*args, **kwargs):
        before_time = time.time()
        print(f"Time before function: {before_time}")

        func(*args, **kwargs)

        after_time = time.time()
        print(f"Time after function: {after_time}")

        # TODO: verify that this is in seconds
        print(f"Operation took: {after_time -before_time} seconds")

    return print_metrics


def generate_df_with_n_rows(rows):
    return spark.createDataFrame(
        [
            [random.randint(1, 10)] for row in range(rows)
        ],
        StructType([StructField("a", StringType(), True)])
    )


@time_it
def perform_inner_join(df_one, df_two, key_to_join_on):
    df_one.join(df_two, on=[key_to_join_on]).show()


def configure_argparse():
    parser = ArgumentParser()
    parser.add_argument("rows_of_df_one", type=int, help="This is the number of rows of dataframe one")
    parser.add_argument("rows_of_df_two", type=int, help="This is the number of rows of dataframe two")

    return vars(parser.parse_args()).values()


def main():
    rows_df_one, rows_df_two = configure_argparse()
    df_one, df_two = generate_df_with_n_rows(rows_df_one), generate_df_with_n_rows(rows_df_two)

    # LETS TIME THE FOLLOWING OPERATIONS
    perform_inner_join(df_one, df_two, 'a')
    # perform_left_join
    # perform_right_join


if __name__ == '__main__':
    spark = SparkSession.builder.appName("Spark Benchmark").getOrCreate()
    main()
