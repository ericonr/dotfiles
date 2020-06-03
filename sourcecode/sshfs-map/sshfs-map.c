#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <mntent.h>
#include <limits.h>
#include <linux/limits.h>

#include "sshfs-map.h"

int main(int argc, char **argv)
{
	sshfs_mode mode;
	if (strstr(argv[0], "sshfs-map") != NULL) {
		puts("map mode");
		mode = SSHFS_MAP;
	} else if (strstr(argv[0], "sshfs-unmap") != NULL) {
		puts("unmap mode");
		mode = SSHFS_UNMAP;
	} else {
		puts("must be launched as sshfs-map or sshfs-unmap");
		exit(1);
	}

	FILE *map = fopen("map", "r");
	if (map == NULL) {
		puts("couldn't find 'map' file");
		exit(1);
	}

	char *line = NULL;
	size_t line_size = 0;
	int i = 0;
	
	while (true) {
		size_t result = getline(&line, &line_size, map);
		// EOF
		if (result == -1) {
			break;
		}

		// comment *or*
		// lines smaller than 3 characters
		// can't be valid
		if (result < 3 || line[0] == '#') {
			continue;
		}

		// guarantee null-terminated terms
		if (line[result - 1] == '\n') line[result - 1] = '\0';


		char *source, *dest, *full_dest;
		source = dest = full_dest = NULL;
		sscanf(line, "%ms %ms", &source, &dest);
		printf("map #%02d: %s\n", i, line);

		if (dest[0] == '/') {
			full_dest = dest;
		} else {
			full_dest = realpath(dest, NULL);
			if (full_dest == NULL) {
				puts("couldn't find path");
				exit(1);
			}
		}

		// check path mount status
		FILE *mtab = setmntent("/etc/mtab", "r");
		bool is_mounted = false;
		while (true) {
			struct mntent *mounts = getmntent(mtab);
			if (mounts == NULL) {
				break;
			}
			if (strcmp(full_dest, mounts->mnt_dir) == 0) {
				is_mounted = true;
				break;
			}
		}
		endmntent(mtab);

		switch (mode) {
			pid_t p;
			case SSHFS_MAP:
				if (is_mounted) {
					printf("%s is already mounted\n", full_dest);
					continue;
				}
				p = fork();
				if (p == 0) {
					printf("%s <=> %s\n", source, full_dest);
					fflush(stdout);

					char *args[] = {"sshfs", source, full_dest, NULL};
					execvp("sshfs", args);
				} else {
					int wstatus;
					waitpid(p, &wstatus, 0);
				}
				break;

			case SSHFS_UNMAP:
				if (!is_mounted) {
					printf("%s isn't mounted\n", full_dest);
					continue;
				}
				p = fork();
				if (p == 0) {
					char *args[] = {"umount", full_dest, NULL};
					execvp("umount", args);
				} else {
					int wstatus;
					waitpid(p, &wstatus, 0);
				}
				break;
		}

		free(line);
		free(source);
		free(dest);
		if (full_dest != dest) free(full_dest);

		i++; // update count
	}

	fclose(map);
	return 0;
}
