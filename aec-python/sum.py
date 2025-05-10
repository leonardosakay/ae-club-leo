import argparse

parser = argparse.ArgumentParser(description="Sum two numbers.")
parser.add_argument("int_to_sum", nargs=2, type=int, help="Two integers to sum")
args = parser.parse_args()

oursum = sum(args.int_to_sum)
print(f"The sum of {args.int_to_sum} is {oursum}")
