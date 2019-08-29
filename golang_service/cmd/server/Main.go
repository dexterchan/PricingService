package main

import (
	"fmt"
	"os"

	"github.com/dexterchan/pricingservice/pkg/cmd"
)

func main() {
	if err := cmd.GrpcPriceServerCmdLine(); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
}
