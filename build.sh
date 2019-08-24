#!/bin/sh
CURPATH=$pwd
cd CPlusCPlus
rm -Rf build
mkdir -p build
cd build
cmake -G 'Unix Makefiles' -DCMAKE_BUILD_TYPE=Debug ..
make -j 8
