#!/sbin/python

import ccxtpro
import asyncio
import sys

# Defining Colors for terminal Easily parseable..
class bcolors:
    OKGREEN = '\033[92m'
    OKRED = '\033[0;31m'
    ENDC = '\033[0;0m'

# coin pairings ##########################################

#pairing = "STARL/USDT"
pairing = "BTC/USDT"

# exchange lists ########################################
#cex = ccxtpro.poloniex
#cex = ccxtpro.ftx
#cex = ccxtpro.binance
cex = ccxtpro.gateio

#########################################################

#parser = argparse.ArgumentParser()
#parser.add_argument("pairing", help = "add in the pairing, such as BTC/USDT...")
#args = parser.parse_args()

# function to get orderbook for pairing
async def get_orderbook():
    exchange = cex({'enableRateLimit': True})
    while True:
        orderbook = await exchange.watch_order_book(pairing)
        print(f"{bcolors.ENDC}{pairing}, \
                {bcolors.OKGREEN}{orderbook['asks'][0]}, \
                {bcolors.OKRED}{orderbook['bids'][0]}")


### main function ####
def main():
    # gets orderbook ticker continually
    asyncio.get_event_loop().run_until_complete(get_orderbook())

main()
