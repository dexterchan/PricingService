#include <cstdio>
#include <sstream>
#include <iostream>
#include "PricingService.h"

//extern "C"
//{
const std::string _GenerateLoanSchedule(
    double amount,
    const double interestYearlyRate,
    const double insuranceYearlyRate,
    const long durationYears,
    const long anticipatedRedemptionPeriod,
    const double anticipatedRedemptionAmount,
    const double anticipatedRedemptionNewMonthlyPayment);
//}

const char *GenerateLoanScheduleGo(
    double amount,
    const double interestYearlyRate,
    const double insuranceYearlyRate,
    const long durationYears,
    const long anticipatedRedemptionPeriod,
    const double anticipatedRedemptionAmount,
    const double anticipatedRedemptionNewMonthlyPayment, int *ret_len)
{

    std::string jsonstr = _GenerateLoanSchedule(amount, interestYearlyRate, insuranceYearlyRate,
                                                durationYears, anticipatedRedemptionPeriod, anticipatedRedemptionAmount,
                                                anticipatedRedemptionNewMonthlyPayment);

    *ret_len = jsonstr.length();
    const char *ret_str = (const char *)malloc(*ret_len);
    memcpy((void *)ret_str, jsonstr.c_str(), *ret_len);
    return ret_str;
}