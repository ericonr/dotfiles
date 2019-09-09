.PHONY: all lnch

all: lnch

lnch: ../script/.local/bin/lnch

../script/.local/bin/%: %.go
	go build -o $@ $<
