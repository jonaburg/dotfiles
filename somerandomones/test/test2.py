#!/sbin/python

import asyncio
import os
import sys
import ccxt.async_support as ccxt
import ccxtpro

# Defining Colors for terminal Easily parseable..
class bcolors:
    OKGREEN = '\033[92m'
    OKRED = '\033[0;31m'
    ENDC = '\033[0;0m'

# coin pairings ##########################################

pairing = "ZIL/USDT"
#pairing = "BTC/USDT"

# exchange lists ########################################
#cex = ccxtpro.poloniex
cex = ccxtpro.ftx
#cex = ccxtpro.binance
#cex = ccxtpro.gateio

#########################################################

async def fetchtick():
    while True:
      ticker = await exchange.fetchTicker(pairing)
      print(ticker)

async def func1():
    exchange = cex({'enableRateLimit': True})
    fetchtick()
    await exchange.close()


def main():
    asyncio.get_event_loop().run_until_complete(func1())

main()

