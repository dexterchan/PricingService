package cmd

import (
	"context"
	"flag"
	"fmt"

	api "github.com/dexterchan/pricingservice/pkg/api/v1"
	server "github.com/dexterchan/pricingservice/pkg/protocol/grpc"
	v1 "github.com/dexterchan/pricingservice/pkg/service/v1"
	"google.golang.org/grpc"
)

// GrpcPriceServerCmdLine : run the gRPC server
func GrpcPriceServerCmdLine() error {
	ctx := context.Background()
	fmt.Println(ctx)
	var port string
	// get configuration
	flag.StringVar(&port, "port", "", "gRPC port to bind")
	flag.Parse()

	fmt.Println("Starting server at port:", port)

	priceAPI := v1.NewPriceServiceServer()

	priceFunc := func(s *grpc.Server) {
		api.RegisterPricingServiceServer(s, priceAPI)
	}

	return server.RunGrpcServer(ctx, port, priceFunc)
}
