def read_numbers_from_file(file_path):
    with open(file_path, 'r') as file:
        numbers = file.read().strip().split()
    return [int(num) for num in numbers]

def sort_numbers(numbers):
    return [numbers[0]] + sorted(numbers[1:])

def format_to_verilog(numbers):
    verilog_lines = []
    for i, num in enumerate(numbers):
        verilog_lines.append(f"li $t0, {num}\nsw $t0, {i * 4}($zero)")
    return verilog_lines

def write_to_file(file_path, lines):
    with open(file_path, 'w') as file:
        for line in lines:
            file.write(line + '\n')

def decs_to_hexstr(decs):
    hexs = [hex(dec)[2:].zfill(8).upper() for dec in decs]
    str_hexs = "".join(hexs)
    return f"{32 * len(hexs)}'h" + "_".join(hexs), " ".join([str_hexs[i:i+2] for i in range(0, len(str_hexs), 2)])
    
def main():
    input_file = 'src/test/asm/data.txt'
    output_file_asm = 'src/test/asm/data.asm'
    output_file_hex = 'src/test/asm/data.hex'
    
    numbers = read_numbers_from_file(input_file)
    verilog_lines = format_to_verilog(numbers)
    hex_lines, hex_list = decs_to_hexstr(numbers)
    hex_lines_sorted, hex_list_sorted = decs_to_hexstr(sort_numbers(numbers))

    write_to_file(output_file_asm, verilog_lines)
    write_to_file(output_file_hex, [hex_lines, hex_list, hex_lines_sorted, hex_list_sorted])

if __name__ == "__main__":
    main()
