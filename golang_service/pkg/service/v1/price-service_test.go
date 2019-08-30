package v1

import (
	"context"
	"fmt"
	"testing"

	v1 "github.com/dexterchan/pricingservice/pkg/api/v1"
	"github.com/stretchr/testify/assert"
)

func TestPrice(t *testing.T) {
	ctx1 := context.Background()

	pricingServer := NewPriceServiceServer()

	tests := []struct {
		name    string
		ctx     context.Context
		req     v1.PriceRequest
		wantErr bool
	}{
		{
			name: "Test1",
			ctx:  ctx1,
			req: v1.PriceRequest{
				Notional:                               672550,
				InterestYearlyRate:                     0.0102,
				InsuranceYearlyRate:                    0.0013,
				DurationYears:                          1,
				AnticipatedRedemptionPeriod:            19,
				AnticipatedRedemptionAmount:            500000,
				AnticipatedRedemptionNewMonthlyPayment: 0,
			},
		},
	}
	fmt.Println("Running test")
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			res, err := pricingServer.Price(tt.ctx, &tt.req)
			if err != nil {
				t.Errorf("Valuation error")
			}
			t.Logf("%T", res.Message)
			assert.GreaterOrEqual(t, len(res.Message), 0)
		})
	}

}
