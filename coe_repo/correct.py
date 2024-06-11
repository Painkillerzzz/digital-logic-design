def decimal_to_binary(numbers):
    binary_numbers = [bin(number)[2:] for number in numbers]
    return binary_numbers

# List of numbers
numbers = [
    154,290,
    197,290,
    240,290,
    283,290,
    326,290,
    369,290,
    412,290,
    455,290,
    455,333,
    498,333,
    541,333,
    584,333,
    627,333,
    670,333,
    713,333
]

# Convert to binary
binary_numbers = decimal_to_binary(numbers)

# Print the result
for decimal, binary in zip(numbers, binary_numbers):
    print(f"{decimal:12b}")
