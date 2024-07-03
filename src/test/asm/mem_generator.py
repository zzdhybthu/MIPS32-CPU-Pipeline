def read_numbers_from_file(file_path):
    with open(file_path, 'r') as file:
        numbers = file.read().strip().split()
    return [int(num) for num in numbers]

def format_to_verilog(numbers):
    verilog_lines = []
    for i, num in enumerate(numbers):
        verilog_lines.append(f"li $t0, {num}\nsw $t0, {i * 4}($zero)")
    return verilog_lines

def write_to_file(file_path, lines):
    with open(file_path, 'w') as file:
        for line in lines:
            file.write(line + '\n')

def main():
    input_file = 'data.txt'
    output_file = 'data.asm'
    
    numbers = read_numbers_from_file(input_file)
    verilog_lines = format_to_verilog(numbers)

    write_to_file(output_file, verilog_lines)

if __name__ == "__main__":
    main()
