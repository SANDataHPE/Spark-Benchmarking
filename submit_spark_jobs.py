import subprocess
from subprocess import CalledProcessError
import re
from tabulate import tabulate


def submit_spark_join_command(left_df_rows, right_df_rows):
    try:
        spark_submit_output = subprocess.check_output(
            f"spark-submit join_table.py {left_df_rows} {right_df_rows}", shell=True
        )

        output = spark_submit_output.decode()

        print("output is {}".format(output))

        for line_of_output in output.split("\n"):
            if "Operation took" in line_of_output:
                benchmark_match = re.match("Operation took: (?P<benchmark>[0-9]+\.[0-9]+) seconds", line_of_output)
                return benchmark_match.group("benchmark")

    except CalledProcessError as e:
        print(f"spark-submit command return error code of 1. Heres the stack trace: {e.output}")


if __name__ == '__main__':
    table = []

    for num_df_rows in [100, 1000, 10000, 1000000]:
        join_benchmark = submit_spark_join_command(num_df_rows, num_df_rows)

        table.append(["Inner Join", num_df_rows, num_df_rows, join_benchmark])


    print(tabulate(table, headers=["Join Type", "# of Left DF Rows", "# of Right DF Rows", "Benchmark"]))