def decimal_to_binary(numbers):
    binary_numbers = [bin(number)[2:] for number in numbers]
    return binary_numbers

# List of numbers
numbers = [
    152, 327,
    195, 327,
    195, 284,
    152, 284,
    152, 327,
    195, 327,
    238, 327,
    281, 327,
    324, 327,
    367, 327,
    367, 284,
    324, 284,
    324, 327,
    367, 327,
    410, 327,
    453, 327,
    496, 327,
    539, 327,
    539, 284,
    496, 284,
    496, 327,
    539, 327,
    582, 327,
    582, 284,
    539, 284,
    539, 327,
    582, 327,
    625, 327,
    625, 284,
    582, 284,
    582, 327,
    625, 327,
    668, 327,
    711, 327
]

# Convert to binary
binary_numbers = decimal_to_binary(numbers)

# Print the result
for decimal, binary in zip(numbers, binary_numbers):
    print(f"{decimal} -> {binary}")
