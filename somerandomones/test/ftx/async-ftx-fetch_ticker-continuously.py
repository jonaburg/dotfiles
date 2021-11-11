#!/sbin/python
# -*- coding: utf-8 -*-

import asyncio
import os
import sys

root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(root + '/python')

import ccxt.async_support as ccxt  # noqa: E402
#import execute_trade.py

###############################################################################
# GLOBAL VARS                                                                 #
##############################################################################
#symbol = 'BTC/USDT'
#symbol = 'ETH/USDT'
#symbol = 'ATOM-PERP'
symbol = 'AXS-PERP'
#acting_price = 36.791244
#acting_price = 5090
acting_price = 129

# output to logfile (later to DB for SQL dashboard metrics + control dashboards).
def write_log(symbol, price, timestamp):
    filename = 'accomplish_log' + '-' + symbol.replace('/', '-') + '.csv'
    print('Recording', symbol, price, filename)
    log_content = [symbol, str(price), str(timestamp)]
    with open(filename, 'w') as file:
        file.write('pairing,' + 'actual price at log,' + 'timestamp of log,' "\n")
        file.write(','.join(log_content) + "\n")


async def main(symbol):
    exchange = ccxt.ftx({
        'enableRateLimit': True,  # this option enables the built-in rate limiter
    })
    current_price = 0.0

    # Change to while (bool representing copmleted task), then return
    #while True:
    while current_price < acting_price:
        print('--------------------------------------------------------------')
        print(exchange.iso8601(exchange.milliseconds()), 'fetching', symbol, 'ticker from', exchange.name)
        # this can be any call instead of fetch_ticker, really
        try:
            ticker = await exchange.fetch_ticker(symbol)
            current_price = float(ticker['info']['price'])
            print(exchange.iso8601(exchange.milliseconds()), 'fetched', symbol, 'ticker from', exchange.name)
            print(ticker)
            # Bigger than branch
            if float(ticker['info']['price']) >= acting_price:
                print(" it\'s bigger or the same as asking price.. ", ticker['info']['price'])
            else:
                print(" it\'s smaller than asking price..", ticker['info']['price'])
        except ccxt.RequestTimeout as e:
            print('[' + type(e).__name__ + ']')
            print(str(e)[0:200])
            # will retry
        except ccxt.DDoSProtection as e:
            print('[' + type(e).__name__ + ']')
            print(str(e.args)[0:200])
            # will retry
        except ccxt.ExchangeNotAvailable as e:
            print('[' + type(e).__name__ + ']')
            print(str(e.args)[0:200])
            # will retry
        except ccxt.ExchangeError as e:
            print('[' + type(e).__name__ + ']')
            print(str(e)[0:200])
            break  # won't retry
    await exchange.close()
    try:
        write_log(symbol, ticker['info']['price'], ticker['timestamp'])
        print('condition satisfied. log in CSV details of this event...')
    except:
        print('unable to be logged.')
        pass

asyncio.get_event_loop().run_until_complete(main(symbol))
