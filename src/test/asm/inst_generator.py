def read_instructions(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    return [line.strip() for line in lines]

def format_instructions(instructions):
    formatted_lines = []
    for i, instruction in enumerate(instructions):
        formatted_line = f"8'd{i}: Inst <= 32'h{instruction};"
        formatted_lines.append(formatted_line)
    return formatted_lines

def write_formatted_instructions(file_path, formatted_lines):
    with open(file_path, 'w') as file:
        for line in formatted_lines:
            file.write(line + '\n')

def main():
    input_file = 'binary_insert_sort.txt'
    output_file = 'binary_insert_sort.inst'

    instructions = read_instructions(input_file)
    formatted_lines = format_instructions(instructions)

    write_formatted_instructions(output_file, formatted_lines)
    
    input_file = 'insert_sort.txt'
    output_file = 'insert_sort.inst'
    
    instructions = read_instructions(input_file)
    formatted_lines = format_instructions(instructions)
    
    write_formatted_instructions(output_file, formatted_lines)

if __name__ == "__main__":
    main()
