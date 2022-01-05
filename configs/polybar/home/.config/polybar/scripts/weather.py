#!/bin/python
# -*- coding: utf-8 -*-

# Go to https://openweathermap.org/city
# Fill in your CITY
# e.g. Recife
# Check url
# https://openweathermap.org/city/3390760
# you will the city code at the end
# create an account on this website
# create an api key (free)

import os

import requests
from requests.exceptions import ConnectionError

CITY = "3390760"  # Recife
API_KEY = os.environ["OPENWEATHERMAP_APIKEY"]  # Fill with your API key
UNITS = "Metric"
UNIT_KEY = "C"
LANG = "pt_br"

try:
    REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&lang={}&appid={}&units={}".format(CITY, LANG,  API_KEY, UNITS))
except ConnectionError:
    print("Error: Connection unavailable")
else:
    try:
        # HTTP CODE = OK
        if REQ.status_code == 200:
            CURRENT = REQ.json()["weather"][0]["description"].capitalize()
            TEMP = int(float(REQ.json()["main"]["temp"]))
            print("{}  {} °{}".format(CURRENT, TEMP, UNIT_KEY))
        else:
            print("Error: BAD HTTP STATUS CODE " + str(REQ.status_code))
    except (ValueError, IOError):
        print("Error: Unable print the data")
