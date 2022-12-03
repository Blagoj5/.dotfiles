package main

import (
	"fmt"
	"os/exec"
)

func execCommand(command string, arg ...string) {
	cmd := exec.Command(command, arg...)

	stdout, err := cmd.Output()

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Print(string(stdout))
}

func installLSPDeps() {
	npmCommands := []string{"install", "-g"}
	dependencies := []string{
		"typescript-language-server",
		"typescript",
		"eslint_d",
		"cspell",
	}

	// TODO: remove the deps that are installed so we speed up the process
	execCommand("npm", append(npmCommands, dependencies...)...)
}

// TODO: check if npm exists before all and stuff like that
func main() {
	installLSPDeps()
}
