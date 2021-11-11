#!/sbin/python
# -*- coding: utf-8 -*-

import os
import sys

root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(root + '/python')

import ccxt  # noqa: E402


exchange = ccxt.ftx({
    'apiKey': 'IXV973ZE41TOUHy5i6wJafZDMCpb_ibJxv3DEPj6',
    'secret': '1481jWDSrzDhUjgmy_98p3M3O1ql4weBq6D1xdGr',
    'enableRateLimit': True,
})

symbol = 'ETH/USDT'  # bitcoin contract according to https://github.com/ccxt/ccxt/wiki/Manual#symbols-and-market-ids
#type = 'StopLimit'  # or 'Market', or 'Stop' or 'StopLimit'
type = 'market'  # valid options include: "limit, market, stop, trailingStop, takeProfit
side = 'sell'  #sell or 'buy'
amount = 0.5
price = None  # or None
#price = 6500.0  # or None

# extra params and overrides
params = {
    'stopPx': 3000.0,  # if needed
}

order = exchange.create_order(symbol, type, side, amount, price, params)
print(order)

