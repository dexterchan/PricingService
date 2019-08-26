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
#include <stdlib.h>
#include <PricingService.h>
*/
import "C"
import (
	"fmt"
	"unsafe"
)

func main() {
	fmt.Println("Hi from Go, about to calculate loan in C++ ...")
	//C.Hello()
	rLen := C.int(0)
	jsonStr := C.GenerateLoanScheduleGo(672550, 0.0102, 0.0013, 1, 19, 500000, 0, &rLen)

	defer C.free(unsafe.Pointer(jsonStr)) // 必须使用C的free函数，释放FooGetName中malloc的内存

	fmt.Printf("%v", C.GoStringN(jsonStr, rLen))
}
