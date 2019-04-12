FROM debian:stable-slim as build-env

RUN apt-get update \
    && apt-get -y install build-essential wget\
    && apt-get -y clean
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.1/cmake-3.14.1-Linux-x86_64.tar.gz
RUN tar xzvf cmake-3.14.1-Linux-x86_64.tar.gz
RUN mkdir -p /usr/src/app/
ENV PATH /cmake-3.14.1-Linux-x86_64/bin:$PATH

ENV PATH /usr/src/app/PricingService:/usr/local/bin:$PATH

RUN mkdir -p /usr/src/app/PricingService/build
WORKDIR /usr/src/app/PricingService


COPY main.cpp ./
COPY CMakeLists.txt ./
RUN cmake -G 'Unix Makefiles' -DCMAKE_BUILD_TYPE=Debug .
RUN cmake --build . --config Release -- -j3

FROM python:3.7-slim-stretch
RUN mkdir -p /usr/src/app/PricingService/build

WORKDIR /usr/src/app/PricingService
COPY requirements.txt ./
COPY PricingService.py ./
RUN  pip install -r requirements.txt
COPY --from=build-env /usr/src/app/PricingService/libLibPricingService.so ./build

CMD ["python3","PricingService.py"]