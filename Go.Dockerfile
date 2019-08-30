FROM golang:1.12.9-stretch as build-env

WORKDIR /
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.1/cmake-3.14.1-Linux-x86_64.tar.gz
RUN tar xzvf cmake-3.14.1-Linux-x86_64.tar.gz
RUN mkdir -p /usr/src/app/
ENV PATH /cmake-3.14.1-Linux-x86_64/bin:$PATH

ENV PATH /usr/src/app/PricingService:/usr/local/bin:$PATH

RUN mkdir -p /usr/src/app/PricingService/build
WORKDIR /usr/src/app/PricingService

RUN mkdir -p CPlusCPlus
RUN mkdir -p golang_service
COPY CPlusCPlus ./CPlusCPlus
COPY golang_service ./golang_service
COPY build.sh ./
RUN sh build.sh

COPY main.go ./
RUN go build -o pricingservice

ENV LD_LIBRARY_PATH /usr/src/app/PricingService/CPlusCPlus/build/

FROM debian:stretch-slim
RUN mkdir -p /usr/src/app/PricingService/CPlusCPlus/build
WORKDIR /usr/src/app/PricingService
COPY --from=build-env /usr/src/app/PricingService/CPlusCPlus/build/libpricingservice.so ./CPlusCPlus/build
COPY --from=build-env /usr/src/app/PricingService/pricingservice .
COPY --from=build-env /usr/src/app/PricingService/golang_service/bin .

ENV LD_LIBRARY_PATH  /usr/src/app/PricingService/CPlusCPlus/build
CMD ["help"]
