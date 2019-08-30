#!/bin/sh
CURPATH=$(pwd)
cd CPlusCPlus
rm -Rf build
mkdir -p build
cd build
cmake -G 'Unix Makefiles' -DCMAKE_BUILD_TYPE=Debug ..
cmake --build . --config Release -- -j3

export LD_LIBRARY_PATH=$CURPATH/CPlusCPlus/build/

cd $CURPATH/golang_service/
rm -Rf $CURPATH/golang_service/bin
mkdir -p $CURPATH/golang_service/bin
cd bin
go build -o priceserver ../cmd/server
go build -o priceclient ../cmd/client

