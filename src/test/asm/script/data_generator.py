def read_numbers_from_file(file_path):
    with open(file_path, 'r') as file:
        numbers = file.read().strip().split()
    return [int(num) for num in numbers]

def sort_numbers(numbers):
    return [numbers[0]] + sorted(numbers[1:])

def write_to_file(file_path, lines):
    with open(file_path, 'w') as file:
        for line in lines:
            file.write(line + '\n')

def decs_to_hexstr(decs):
    hexs = [hex(dec)[2:].zfill(8).upper() for dec in decs]
    str_hexs = "".join(hexs)
    return f"{32 * len(hexs)}'h" + "_".join(hexs), " ".join([str_hexs[i:i+2] for i in range(0, len(str_hexs), 2)])

def decs_to_hexlist(decs):
    hexs = [f"RAM_Data[{idx}] <= 32'h{hex(dec)[2:].zfill(8).upper()};\n" for idx, dec in enumerate(decs)]
    return "".join(hexs)
    
def main():
    input_file = 'src/test/asm/data.txt'
    output_file_hex = 'src/test/asm/data.hex'
    output_file_inst = 'src/test/asm/data.inst'
    
    numbers = read_numbers_from_file(input_file)
    hex_lines, hex_list = decs_to_hexstr(numbers)  # hex string
    hex_lines_sorted, hex_list_sorted = decs_to_hexstr(sort_numbers(numbers))  # hex string, sorted
    hex_inst = decs_to_hexlist(numbers)  # for RAM initialization without uart

    write_to_file(output_file_hex, [hex_lines, hex_list, hex_lines_sorted, hex_list_sorted])
    write_to_file(output_file_inst, [hex_inst])

if __name__ == "__main__":
    main()
