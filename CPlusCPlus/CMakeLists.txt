cmake_minimum_required(VERSION 3.0.0)
project(PricingService VERSION 0.1.0)
set (CMAKE_CXX_STANDARD 11)


include(CTest)
enable_testing()

#add_executable(pricingservice main.cpp)
add_library(pricingservice SHARED main.cpp)
#add_library(pricingservice STATIC main.cpp)

add_library(hello STATIC test.c)


set_target_properties(pricingservice PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS ON
)
set_target_properties(hello PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS ON
)
set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
