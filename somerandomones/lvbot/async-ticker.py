#!/sbin/python
# -*- coding: utf-8 -*-

import asyncio
import os
import sys
from pprint import pprint

root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(root + '/python')

import ccxt.async_support as ccxt  # noqa: E402


async def test(id, symbol):
    exchange = getattr(ccxt, id)({
        'enableRateLimit': True,  # required according to the Manual
    })
    ticker = await exchange.fetch_ticker(symbol)
    await exchange.close()
#    return ticker
    testoutput(ticker)

def testoutput(ticker):
    # deeply nested..
    try:
        print(ticker['info']['price'])
    except KeyError:
        pass
    #print(ticker.get('info', {}).get('price'))

if __name__ == '__main__':
    id = 'ftx'
    symbol = 'ETH/USDT'
    #pprint(asyncio.get_event_loop().run_until_complete(test(id, symbol)))
    asyncio.get_event_loop().run_until_complete(test(id, symbol))
