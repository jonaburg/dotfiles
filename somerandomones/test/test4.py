#!/sbin/python
import requests
import json
import time
import urllib.request
import pandas as pd
import numpy as np

def ExpMovingAverage(values, window):
    weights = np.exp(np.linspace(-1., 0., window))
    weights /= weights.sum()
    a =  np.convolve(values, weights, mode='full')[:len(values)]
    a[:window] = a[window]
    return a


def calcalema(period1,hrsnumbers,basesur,cur):
	# period1 300, 900, 1800, 7200, 14400, and 86400
	rightnow=time.time()
	url ='https://poloniex.com/public?command=returnChartData&currencyPair='+basesur+'_'+cur +'&start=' + str(int(rightnow - hrsnumbers*60*60)) + '&end=9999999999&period='+ str(period1)

	rrie = requests.get(url)
	r2rie=rrie.json()

	lescloses=list()
	for i in r2rie:
		for key,val in i.items():

			lescloses.append(i['close'])


	return  ExpMovingAverage(lescloses, period1)

