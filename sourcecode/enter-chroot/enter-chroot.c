#define _XOPEN_SOURCE
#define _BSD_SOURCE
#include <stdbool.h>
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char * const argv[])
{
	char *mntpoint = "/mnt", *shell = "/bin/fish";
	bool check_chrooted = true;
	int c, rv;

	while ((c = getopt(argc, argv, "m:s:c")) != -1) {
		switch (c) {
			case 'm':
				mntpoint = optarg;
				break;
			case 's':
				shell = optarg;
				break;
			case 'c':
				check_chrooted = false;
				break;
			default:
				fputs("wrong usage", stderr);
				exit(EXIT_FAILURE);
		}
	}

	uid_t
		uid = getuid(),
		euid = geteuid();
	gid_t
		gid = getgid(),
		egid = getegid();

	char cwd[PATH_MAX];
	getcwd(cwd, PATH_MAX);

	if (uid == 0 && gid == 0) {
		fputs("running as root", stderr);
	} else {
		fprintf(stderr, "running as %d:%d\n", uid, gid);
	}
	fprintf(stderr, "effective perms %d:%d\n", euid, egid);

	// check if <mntpoint> exists and/or can be accessed
	{
		int mntpoint_rv = 0;
		struct stat mntpoint_stat = {0};
		mntpoint_rv = stat(mntpoint, &mntpoint_stat);
		if (mntpoint_rv == -1) {
			fprintf(stderr, "couldn't stat '%s': %m\n", mntpoint);
			exit(EXIT_FAILURE);
		}
	}

	// check for the presense of <mntpoint>/chrooted
	if (check_chrooted) {
		char chrooted[PATH_MAX] = {0};
		int chrooted_rv = 0;
		struct stat chrooted_stat = {0};
		strncpy(chrooted, mntpoint, PATH_MAX);
		strncat(chrooted, "/chrooted", PATH_MAX - 1);
		fprintf(stderr, "checking file in '%s'\n", chrooted);

		chrooted_rv = stat(chrooted, &chrooted_stat);
		if (chrooted_rv == -1 && errno == ENOENT) {
			fprintf(stderr, "'%s' doesn't exist, aborting...\n", chrooted);
			exit(EXIT_FAILURE);
		}
	}

	rv = chroot(mntpoint);
	if (rv == -1) {
		fprintf(stderr, "chroot failed: %m\n");
		exit(EXIT_FAILURE);
	}

	rv = setenv("CHROOTED", "1", 1);
	if (rv == -1) {
		fprintf(stderr, "CHROOTED not set in env: %m\n");
		// non-fatal
	}

	rv = setgid(gid);
	if (rv == -1) {
		fprintf(stderr, "setgid failed: %m\n");
		exit(EXIT_FAILURE);
	}
	rv = setuid(uid);
	if(rv == -1) {
		fprintf(stderr, "setuid failed: %m\n");
		exit(EXIT_FAILURE);
	}

	rv = chdir(cwd);
	if (rv == -1) {
		fprintf(stderr, "chdir failed: %m\n");
		// non-fatal
	}

	char *shellv[] = {shell, NULL};
	rv = execv(shell, shellv);
	fprintf(stderr, "execv %s failed: %m\n", shell);
	return EXIT_FAILURE;
}
