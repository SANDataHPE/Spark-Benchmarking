import time

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