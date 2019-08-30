FROM debian:stable-slim as build-env

RUN apt-get update \
    && apt-get -y install build-essential wget\
    && apt-get -y clean
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.1/cmake-3.14.1-Linux-x86_64.tar.gz
RUN tar xzvf cmake-3.14.1-Linux-x86_64.tar.gz
RUN mkdir -p /usr/src/app/
ENV PATH /cmake-3.14.1-Linux-x86_64/bin:$PATH

ENV PATH /usr/src/app/PricingService:/usr/local/bin:$PATH

WORKDIR /usr/src/app/PricingService

RUN mkdir -p CPlusCPlus
COPY CPlusCPlus ./CPlusCPlus
COPY build.sh ./
RUN sh build.sh

FROM python:3.7-slim-stretch
RUN mkdir -p /usr/src/app/PricingService/CPlusCPlus/build
RUN mkdir -p /usr/src/app/PricingService/python_service

WORKDIR /usr/src/app/PricingService
COPY ./python_service ./python_service
RUN  pip install -r python_service/requirements.txt
COPY --from=build-env /usr/src/app/PricingService/CPlusCPlus/build/libpricingservice.so /usr/src/app/PricingService/CPlusCPlus/build

CMD ["python3","python_service/PricingService.py"]




