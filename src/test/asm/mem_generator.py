def read_numbers_from_file(file_path):
    with open(file_path, 'r') as file:
        numbers = file.read().strip().split()
    return [int(num) for num in numbers]

def convert_to_hex(numbers):
    return [f"{num:08x}" for num in numbers]

def format_to_verilog(hex_numbers):
    verilog_lines = []
    for i, hex_num in enumerate(hex_numbers):
        verilog_lines.append(f"RAM_data[{i}] <= 32'h{hex_num};")
    return verilog_lines

def write_to_file(file_path, lines):
    with open(file_path, 'w') as file:
        for line in lines:
            file.write(line + '\n')

def main():
    input_file = 'data.txt'
    output_file = 'data.mem'
    
    numbers = read_numbers_from_file(input_file)
    hex_numbers = convert_to_hex(numbers)
    verilog_lines = format_to_verilog(hex_numbers)

    write_to_file(output_file, verilog_lines)

if __name__ == "__main__":
    main()
