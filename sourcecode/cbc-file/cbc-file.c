#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

#include <bearssl.h>

#define INPUT_PASS_LENGTH 8
#define PASS_LENGTH 16

static void usage(void)
{
    fputs("Usage: cbd-file lock|unlock <file>", stderr);
    exit(1);
}

static void read_password(uint8_t *key)
{
    fprintf(stderr, "input password (%d): ", INPUT_PASS_LENGTH);
    fread(key, 1, INPUT_PASS_LENGTH, stdin);
}

static off_t file_size(int fd)
{
    struct stat s = { 0 };
    int rv = fstat(fd, &s);
    if (rv != 0) {
        fprintf(stderr, "couldn't stat file: %m\n");
        exit(100);
    }
    return s.st_size;
}

static ssize_t open_file_for_read(char *name, uint8_t **buffer)
{
    int f = open(name, O_RDONLY);
    if (f < 0) {
        fputs("couldn't open file!", stderr);
        exit(100);
    }

    off_t size = file_size(f);
    ssize_t blocks = size / br_aes_big_BLOCK_SIZE;
    if (blocks * br_aes_big_BLOCK_SIZE < size) blocks++;
    fprintf(stderr, "total blocks: %lu\n", blocks);

    FILE *file = fdopen(f, "r");
    *buffer = calloc(blocks, br_aes_big_BLOCK_SIZE);
    if (buffer == 0) {
        fprintf(stderr, "couldn't allocate buffer: %m\n");
        exit(101);
    }
    fread(*buffer, size, 1, file);
    fclose(file);

    return blocks * br_aes_big_BLOCK_SIZE;
}

int main(int argc, char **argv)
{
    if (argc < 3) {
        usage();
    }

    if (strcmp(argv[1], "lock") == 0) {
        // locking code
        uint8_t *buffer;
        ssize_t bytes = open_file_for_read(argv[2], &buffer);

        uint8_t key[PASS_LENGTH] = { 0 };
        uint8_t iv[32] = { 0 };
        read_password(key);

        br_aes_big_cbcenc_keys br = { 0 };
        br_aes_big_cbcenc_init(&br, key, PASS_LENGTH);
        br_aes_big_cbcenc_run(&br, iv, buffer, bytes);
        fwrite(buffer, 1, bytes, stdout);
    } else if (strcmp(argv[1], "unlock") == 0) {
        // unlocking code
        uint8_t *buffer;
        ssize_t bytes = open_file_for_read(argv[2], &buffer);

        uint8_t key[PASS_LENGTH] = { 0 };
        uint8_t iv[32] = { 0 };
        read_password(key);

        br_aes_big_cbcdec_keys br = { 0 };
        br_aes_big_cbcdec_init(&br, key, PASS_LENGTH);
        br_aes_big_cbcdec_run(&br, iv, buffer, bytes);
        fwrite(buffer, 1, bytes, stdout);
    } else {
        usage();
    }

    return 0;
}
