package v1

/*
#cgo darwin LDFLAGS: -lpricingservice
#cgo linux LDFLAGS: -lpricingservice
#cgo LDFLAGS: -L"${SRCDIR}/../../../../CPlusCPlus/build"
#cgo CFLAGS: -I${SRCDIR}/../../../../CPlusCPlus
#include <stdlib.h>
#include <PricingService.h>
*/
import "C"
import (
	"context"
	"fmt"
	"log"
	"unsafe"

	v1 "github.com/dexterchan/pricingservice/pkg/api/v1"
)

type priceServiceServer struct {
}

//NewPriceServiceServer create instance of PricingServiceServer implementation
func NewPriceServiceServer() v1.PricingServiceServer {
	return &priceServiceServer{}
}

func (s priceServiceServer) Price(ctx context.Context, r *v1.PriceRequest) (*v1.PriceResponse, error) {
	log.Println("Calling Price via C++")
	rLen := C.int(0)

	jsonStr := C.GenerateLoanScheduleGo(C.double(r.Notional), C.double(r.InterestYearlyRate), C.double(r.InsuranceYearlyRate),
		C.long(r.DurationYears),
		C.long(r.AnticipatedRedemptionPeriod), C.double(r.AnticipatedRedemptionAmount),
		C.double(r.AnticipatedRedemptionNewMonthlyPayment), &rLen)

	defer C.free(unsafe.Pointer(jsonStr)) // free malloc build jsonstr

	retString := fmt.Sprintf("%v", C.GoStringN(jsonStr, rLen))

	return &v1.PriceResponse{
		Status:  v1.PriceResponse_SUCCESS,
		Message: retString,
	}, nil
}
