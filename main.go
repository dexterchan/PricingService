package main

//Reference: https://dev.twsiyuan.com/2018/04/go-cgo-with-static-linking-library.html
//https://yangxikun.com/golang/2018/03/09/golang-cgo.html
/* C lib call
** #cgo CFLAGS: -I${SRCDIR}/CPlusCPlus
** #cgo LDFLAGS: ${SRCDIR}/CPlusCPlus/build/libhello.a
** #include <PricingService.h>
 */
//C++ lib call

/*
#cgo darwin LDFLAGS: -lpricingservice
#cgo linux LDFLAGS: -lpricingservice
#cgo LDFLAGS: -L"${SRCDIR}/CPlusCPlus/build"
#cgo CFLAGS: -I${SRCDIR}/CPlusCPlus
#include <PricingService.h>
*/
import "C"
import (
	"fmt"
)

func main() {
	fmt.Println("Hi from Go, about to calculate loan in C++ ...")
	//C.Hello()
	C.GenerateLoanScheduleNoOutput(672550, 0.0102, 0.0013, 1, 19, 500000, 0)

	//defer C.free(unsafe.Pointer(jsonstr))
	//fmt.Printf("%v", jsonstr)
}
