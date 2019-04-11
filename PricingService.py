from ctypes import *
from flask import Flask
from flask_restful import Api, Resource,reqparse

import json
import time

app = Flask(__name__)
api = Api(app)
PricingServiceLib = cdll.LoadLibrary("./build/libLibPricingService.dylib")
PricingServiceLib.GenerateLoanSchedule.argtypes = [c_double,c_double,c_double,c_long,c_long,c_double,c_double]
PricingServiceLib.GenerateLoanSchedule.restype = c_char_p


@app.route("/GenerateLoanSchedule")
def get():
    parser = reqparse.RequestParser()
    parser.add_argument("amount",type=float,default=672550)
    parser.add_argument("interestYearlyRate",type=float,default=0.006)
    parser.add_argument("insuranceYearlyRate",type=float,default=0.00122)
    parser.add_argument("durationYears",type=int,default=12)
    parser.add_argument("anticipatedRedemptionPeriod",type=int,default=19)
    parser.add_argument("anticipatedRedemptionAmount",type=float, default=1000000)
    parser.add_argument("anticipatedRedemptionNewMonthlyPayment",type=float,default=0)

    args = parser.parse_args()
    scheduleStr = PricingServiceLib.GenerateLoanSchedule(
        args["amount"],
        args["interestYearlyRate"],
        args["insuranceYearlyRate"],
        args["durationYears"],
        args["anticipatedRedemptionPeriod"],
        args["anticipatedRedemptionAmount"],
        args["anticipatedRedemptionNewMonthlyPayment"]
    )
    return str(json.loads(scheduleStr)),200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

