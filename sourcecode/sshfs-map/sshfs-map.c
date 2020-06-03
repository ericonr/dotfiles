#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

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

		char *source, *dist;
		source = dist = NULL;
		sscanf(line, "%ms %ms", &source, &dist);
		printf("map #%02d: %s\n", i, line);

		switch (mode) {
			pid_t p;
			case SSHFS_MAP:
				p = fork();
				if (p == 0) {
					printf("%s <=> %s\n", source, dist);
					fflush(stdout);

					char *args[] = {"sshfs", source, dist, NULL};
					execvp("sshfs", args);
				} else {
					int wstatus;
					waitpid(p, &wstatus, 0);
				}
				break;

			case SSHFS_UNMAP:
				p = fork();
				if (p == 0) {
					char *args[] = {"umount", dist, NULL};
					execvp("umount", args);
				} else {
					int wstatus;
					waitpid(p, &wstatus, 0);
				}
				break;
		}
		free(line);
		i++; // update count
	}
}
