#!/sbin/python
# -*- coding: utf-8 -*-

import os
import sys

root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(root + '/python')

import ccxt  # noqa: E402


# make sure your version is 1.51+
#print('CCXT Version:', ccxt.__version__)

exchange = ccxt.ftx({
    'apiKey': 'IXV973ZE41TOUHy5i6wJafZDMCpb_ibJxv3DEPj6',
    'secret': '1481jWDSrzDhUjgmy_98p3M3O1ql4weBq6D1xdGr',
})


markets = exchange.load_markets ()

#exchange.verbose = True  # uncomment for debugging

all_trades = {}
symbol = None
since = None
limit = 200
end_time = exchange.milliseconds()

print(exchange.fetchBalance())
