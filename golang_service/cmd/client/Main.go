package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"time"

	api "github.com/dexterchan/pricingservice/pkg/api/v1"
	"google.golang.org/grpc"
)

func main() {
	// get configuration
	address := flag.String("server", "", "gRPC server in format host:port")
	flag.Parse()

	// Set up a connection to the server.
	conn, err := grpc.Dial(*address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	c := api.NewPricingServiceClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Minute)
	defer cancel()

	res1, err := c.Price(ctx, &api.PriceRequest{
		Notional:                               672550,
		InterestYearlyRate:                     0.0102,
		InsuranceYearlyRate:                    0.0013,
		DurationYears:                          1,
		AnticipatedRedemptionPeriod:            19,
		AnticipatedRedemptionAmount:            500000,
		AnticipatedRedemptionNewMonthlyPayment: 0,
	})
	if err != nil {
		log.Fatalf("Price failed: %v", err)
	}
	fmt.Printf("Output is %v:", res1)

}
