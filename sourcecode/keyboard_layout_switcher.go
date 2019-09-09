package main

import (
	"fmt"
	"strings"
	"strconv"
	"encoding/json"
	"os/exec"
	"log"
)

func main() {
	// collecting the JSON output from swaymsg
	cmd_in := exec.Command("swaymsg", "--raw", "--type", "get_inputs")
	stdout, err := cmd_in.Output()
	if err != nil {
		log.Fatal(err)
	}

	// struct that represents the Input
	type Input struct {
		Identifier, Name string
		Vendor, Product int
		Type string
		Xkb_Layout_Names []string
		Xkb_Active_Layout_Index int
		Xkb_Active_Layout_Name string
	}

	// JSON decoder and getting the first token ('[')
	dec := json.NewDecoder(strings.NewReader(string(stdout)))
	_, err = dec.Token()
	if err != nil {
		log.Fatal(err)
	}

	// filtering amongst the keeyboards for the one with the most layouts setup
	max_length := 0
	var keyboard_input Input
	for dec.More() {
		var input Input
		err := dec.Decode(&input)
		if err != nil {
			log.Fatal(err)
		}

		length := len(input.Xkb_Layout_Names)

		if input.Type == "keyboard" && length > max_length {
			max_length = length
			keyboard_input = input
		}
	}

	// finding the index of the input
	var current_index int
	for i, layout := range keyboard_input.Xkb_Layout_Names {
		if keyboard_input.Xkb_Active_Layout_Name == layout {
			current_index = i
			break
		}
	}

	// setting the next index of the output
	var next_index int
	if current_index < (len(keyboard_input.Xkb_Layout_Names) - 1) {
		next_index = current_index + 1
	} else {
		next_index = 0
	}

	// setting the new layout index
	cmd_out := exec.Command("swaymsg", "input", keyboard_input.Identifier, "xkb_switch_layout", strconv.Itoa(next_index))
	_, err = cmd_out.Output()
	if err != nil {
		log.Fatal(err)
	} else {
		fmt.Printf("%v switched to layout %v successfully.\n", keyboard_input.Name, keyboard_input.Xkb_Layout_Names[next_index])
	}
}
