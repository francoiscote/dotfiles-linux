#!/bin/python

import urllib.request, json

city = "Montreal,CA"
api_key = "c0ae25eb007ab339ffe22de1c764c970"
units = "Metric"
unit_key = "C"

weather = eval(str(urllib.request.urlopen("http://api.openweathermap.org/data/2.5/weather?q={}&APPID={}&units={}".format(city, api_key, units)).read())[2:-1])

info = weather["weather"][0]["description"].capitalize()
temp = int(float(weather["main"]["temp"]))

print("%s, %i°%s" % (info, temp, unit_key))
