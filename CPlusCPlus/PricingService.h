#ifndef PRICING_H
#define PRICING_H

#ifdef WINDOWS
#define API __declspec(dllexport)
#else
#define API extern
#endif

// __cplusplus gets defined when a C++ compiler processes the file
#ifdef __cplusplus
// extern "C" is needed so the C++ compiler exports the symbols without name
// manging.
extern "C"
{
#endif

    API const char *GenerateLoanSchedule(
        double amount,
        const double interestYearlyRate,
        const double insuranceYearlyRate,
        const long durationYears,
        const long anticipatedRedemptionPeriod,
        const double anticipatedRedemptionAmount,
        const double anticipatedRedemptionNewMonthlyPayment);

    API void GenerateLoanScheduleNoOutput(
        double amount,
        const double interestYearlyRate,
        const double insuranceYearlyRate,
        const long durationYears,
        const long anticipatedRedemptionPeriod,
        const double anticipatedRedemptionAmount,
        const double anticipatedRedemptionNewMonthlyPayment);
    API int Hello();
#ifdef __cplusplus
}
#endif
#endif