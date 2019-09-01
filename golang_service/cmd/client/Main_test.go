package main

import (
	"context"
	"fmt"
	"log"
	"testing"
	"time"

	api "github.com/dexterchan/pricingservice/pkg/api/v1"
	server "github.com/dexterchan/pricingservice/pkg/protocol/grpc"
	v1 "github.com/dexterchan/pricingservice/pkg/service/v1"
	"google.golang.org/grpc"
)

const PORT = "9090"

var conn *grpc.ClientConn
var err error
var client api.PricingServiceClient
var ctx context.Context
var cancel context.CancelFunc

func init() {
	address := fmt.Sprintf("localhost:%v", PORT)
	/* load test data */
	conn, err = grpc.Dial(address, grpc.WithInsecure())
	client = api.NewPricingServiceClient(conn)

	ctx, cancel = context.WithTimeout(context.Background(), 5*time.Minute)
	runserver()
	time.Sleep(5 * time.Second)
}

func BenchmarkPriceCall(t *testing.B) {
	for i := 0; i < t.N; i++ {
		_, err := client.Price(ctx, &api.PriceRequest{
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
	}

}

func runserver() {
	go func() {
		ctxS := context.Background()

		priceAPI := v1.NewPriceServiceServer()

		priceFunc := func(s *grpc.Server) {
			api.RegisterPricingServiceServer(s, priceAPI)
		}
		server.RunGrpcServer(ctxS, PORT, priceFunc)
	}()
}
