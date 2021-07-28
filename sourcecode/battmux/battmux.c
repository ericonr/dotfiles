#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

// tmux or term colors
#define FGCOLOR(c) "#[fg=colour" c "]"
//#define FGCOLOR(c) "\x1b[38;5;" c "m" // https://en.wikipedia.org/wiki/ANSI_escape_code

#define BATPATH "/sys/class/power_supply/BAT0/"

int main()
{
	char s[64];
	struct timespec t;
	struct tm tm;

	if (clock_gettime(CLOCK_REALTIME, &t) < 0) return 1;
	localtime_r(&t.tv_sec, &tm);
	strftime(s, sizeof s, "%H:%M   %d/%m   %Y", &tm);
	fputs(" " FGCOLOR("15"), stdout);
	fputs(s, stdout);
	fputs(FGCOLOR("0") "   ", stdout);

	int capfd = open(BATPATH "capacity", O_RDONLY);
	int stafd = open(BATPATH "status", O_RDONLY);
	if (capfd<0 || stafd<0) return 0;

	if (read(stafd, s, sizeof s) >= 0)
		if (strstr(s, "Charging"))
			fputs("+ ", stdout);
	close(stafd);

	if (read(capfd, s, sizeof s) < 0) return 1;
	close(capfd);
	int cap = atoi(s);
	for (int i = 0; i < 5; i++)
		if (i <= cap / 20)
			fputs(FGCOLOR("1") "♥ ", stdout);
		else
			fputs(FGCOLOR("8") "♥ ", stdout);
}
