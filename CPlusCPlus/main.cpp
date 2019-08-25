#include <cstdio>

#include <math.h>
#include <sstream>
#include <iostream>
#include "PricingService.h"

std::string months2String(long months)
{
	const long nbYears = (long)floor(months / 12.);
	const long nbMonths = months - (12 * nbYears);
	std::ostringstream results;
	if (nbYears == 0)
	{
		results << nbMonths << " months";
	}
	else
	{
		results << nbYears << " year";
		if (nbYears > 1)
			results << "s";
		if (nbMonths > 0)
		{
			results << " and " << nbMonths << " month";
			if (nbMonths > 1)
				results << "s";
		}
	}
	return results.str();
}

std::string formatPrice(double price)
{
	std::ostringstream result;
	result.precision(2);
	result << std::fixed << price;
	return result.str();
}

const std::string _GenerateLoanSchedule(
	double amount,
	const double interestYearlyRate,
	const double insuranceYearlyRate,
	const long durationYears,
	const long anticipatedRedemptionPeriod,
	const double anticipatedRedemptionAmount,
	const double anticipatedRedemptionNewMonthlyPayment)
{
	static std::string resultStr;
	double rho(pow(1. + (interestYearlyRate / 12.), durationYears * 12.));
	double monthlyPaymentWithoutInsurance = amount * interestYearlyRate * rho / (rho - 1.) / 12.;
	double dueCapitalAtEndOfPeriod(amount);
	double totalRedemptedCapital(0.);
	double totalInterests(0.);
	double totalInsurance(0.);

	std::ostringstream schedule;
	long i = 0;
	for (; dueCapitalAtEndOfPeriod > 0.; ++i)
	{
		double periodInsurance = amount * insuranceYearlyRate / 12;
		if (anticipatedRedemptionPeriod == i)
		{
			dueCapitalAtEndOfPeriod -= anticipatedRedemptionAmount;
			totalRedemptedCapital += anticipatedRedemptionAmount;
			amount -= anticipatedRedemptionAmount;
			periodInsurance = amount * insuranceYearlyRate / 12.;
			if (anticipatedRedemptionNewMonthlyPayment > 0.)
			{
				monthlyPaymentWithoutInsurance = anticipatedRedemptionNewMonthlyPayment - periodInsurance;
			}
			else
			{
				rho = pow(1. + (interestYearlyRate / 12.), durationYears * 12. - i);
				monthlyPaymentWithoutInsurance = dueCapitalAtEndOfPeriod * interestYearlyRate * rho / (rho - 1) / 12;
			}
		}
		const double periodInterests = dueCapitalAtEndOfPeriod * interestYearlyRate / 12;
		double redemptedCapital = monthlyPaymentWithoutInsurance - periodInterests;
		totalInterests += periodInterests;
		totalInsurance += periodInsurance;
		dueCapitalAtEndOfPeriod -= redemptedCapital;
		if (dueCapitalAtEndOfPeriod < 0.)
		{
			redemptedCapital += dueCapitalAtEndOfPeriod;
			monthlyPaymentWithoutInsurance += dueCapitalAtEndOfPeriod;
			dueCapitalAtEndOfPeriod = 0.;
		}
		totalRedemptedCapital += redemptedCapital;
		if (i > 0)
		{
			schedule << ",";
		}
		schedule << "{"
				 << "\"period\":\"" << i << "\","
				 << "\"totalPayment\":\"" << formatPrice(monthlyPaymentWithoutInsurance + periodInsurance) << "\","
				 << "\"paidInterests\":\"" << formatPrice(periodInterests) << "\","
				 << "\"paidInsurance\":\"" << formatPrice(periodInsurance) << "\","
				 << "\"redemptedCapital\":\"" << formatPrice(redemptedCapital) << "\","
				 << "\"dueCapitalAtEndOfPeriod\":\"" << formatPrice(dueCapitalAtEndOfPeriod) << "\","
				 << "\"totalRedemptedCapital\":\"" << formatPrice(totalRedemptedCapital) << "\""
				 << "}";
	}

	std::ostringstream result;
	result << "{"
		   << "\"duration\": \"" << months2String(i - 1) << "\","
		   << "\"totalRedemptedCapital\": \"" << formatPrice(totalRedemptedCapital) << "\","
		   << "\"totalInterests\": \"" << formatPrice(totalInterests) << "\","
		   << "\"totalInsurance\": \"" << formatPrice(totalInsurance) << "\","
		   << "\"totalInterestsAndInsurance\": \"" << formatPrice(totalInterests + totalInsurance) << "\","
		   << "\"schedule\": [" << schedule.str() << "]"
		   << "}";

	return result.str();
}

const char *GenerateLoanSchedule(
	double amount,
	const double interestYearlyRate,
	const double insuranceYearlyRate,
	const long durationYears,
	const long anticipatedRedemptionPeriod,
	const double anticipatedRedemptionAmount,
	const double anticipatedRedemptionNewMonthlyPayment)
{
	std::string str = _GenerateLoanSchedule(amount, interestYearlyRate, insuranceYearlyRate,
											durationYears, anticipatedRedemptionPeriod, anticipatedRedemptionAmount,
											anticipatedRedemptionNewMonthlyPayment);
	return str.c_str();
}

void GenerateLoanScheduleNoOutput(
	double amount,
	const double interestYearlyRate,
	const double insuranceYearlyRate,
	const long durationYears,
	const long anticipatedRedemptionPeriod,
	const double anticipatedRedemptionAmount,
	const double anticipatedRedemptionNewMonthlyPayment)
{
	const char *result = GenerateLoanSchedule(amount, interestYearlyRate, insuranceYearlyRate,
											  durationYears, anticipatedRedemptionPeriod, anticipatedRedemptionAmount,
											  anticipatedRedemptionNewMonthlyPayment);
	std::cout << result << std::endl;
}

int Hello()
{
	std::cout << "Hello from C++ Pricing Service!" << std::endl;
	return 0;
}

int main(void)
{
	int retSize = 0;
	const char *ret = GenerateLoanScheduleGo(672550, 0.0102, 0.0013, 1, 19, 500000, 0, &retSize);
	std::cout << ret << std::endl;
}