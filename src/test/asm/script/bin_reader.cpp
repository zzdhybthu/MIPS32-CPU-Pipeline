#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <binary_file>\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char *file_name = argv[1];
    FILE *file = fopen(file_name, "rb");
    if (!file) {
        perror("Failed to open file");
        return EXIT_FAILURE;
    }

    int num;
    while (fread(&num, sizeof(int), 1, file) == 1) {
        printf("%d ", num);
    }

    fclose(file);
    return EXIT_SUCCESS;
}
