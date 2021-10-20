package main
import (
	"os"
	"os/exec"
	"fmt"
	"bytes"
)

func main() {
	cmd := exec.Command("helloworld")
	pipe, err := cmd.StdoutPipe()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	err = cmd.Start()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	buf := new(bytes.Buffer)
    buf.ReadFrom(pipe)
    newStr := buf.String()

	err = cmd.Wait()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

    fmt.Println(newStr)
}