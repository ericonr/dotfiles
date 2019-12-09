// program taken from https://github.com/oem/lnch

package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"syscall"
)

func main() {
	if len(os.Args) <= 1 {
		fmt.Println("Usage: lnch <command> <optional parameters>")
		os.Exit(1)
	}
	cmd := exec.Command(os.Args[1], os.Args[2:]...)

	// this is the important part to avoid killing the child process instantly
	cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}

	err := cmd.Start()
	if err != nil {
		log.Fatal(err)
	}
}
