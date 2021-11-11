#!/sbin/python
# -*- coding: utf-8 -*-

import asyncio
import os
import sys

import ccxt
import re
import time
import pandas as pd

from stockstats import StockDataFrame as Sdf

root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.append(root + '/python')

import ccxt.async_support as ccxt  # noqa: E402

###############################################################################
# GLOBAL VARS                                                                 #
##############################################################################
symbol = 'BTC/USDT'
acting_price = 90901

# Outputs some information to logfile (later to DB for SQL dashboard metrics + control dashboards).
def write_log(symbol, price, timestamp):
# Args:
#      symbol : BTC/USDT
#      price:  current price of the pairing
#      timestamp: timestamp of the pairing
    filename = 'accomplish_log' + '-' + symbol.replace('/', '-') + '.csv'
    print('Recording', symbol, price, filename)
    log_content = [symbol, str(price), str(timestamp)]
    with open(filename, 'w') as file:
        file.write('pairing,' + 'actual price at log,' + 'timestamp of log,' "\n")
        file.write(','.join(log_content) + "\n")

# Asynchronously gets historical data (OHLCV) from exchange. Stores in dataframe written to CSV. Returns df.
# Args:
#      symbol : BTC/USDT
#      exchange:  ccxt.ftx (should anyways be defined already in main loop)
#      timeframe: what timeframe spaces are within.
# Returns:
#      dataframe
async def get_historical_data(symbol, exchange, timeframe):
    # optional: exchange.fetch_ohlcv(symbol, '1h', since)
    data = await exchange.fetch_ohlcv(symbol, timeframe)
    # update timestamp to human readable timestamp
    data = [[exchange.iso8601(candle[0])] + candle[1:] for candle in data]
    #data = [[exchange.candle[0]] + candle[1:] for candle in data]
    header = ['Timestamp', 'Open', 'High', 'Low', 'Close', 'Volume']
    df = pd.DataFrame(data, columns=header)
    df.to_csv('database.csv')
    return df

def create_stock(historical_data):
    """Create StockData from historical data
    """
    stock  = Sdf.retype(historical_data)
    return stock


async def main(symbol):
    exchange = ccxt.ftx({
        'enableRateLimit': True,  # this option enables the built-in rate limiter
    })
    current_price = 0.0

    time.sleep (exchange.rateLimit / 1000)
    data = await get_historical_data(symbol, exchange, '1h')
    stock_data = create_stock(data)
    print(stock_data)
   # print(stock_data['macd'])
    print(stock_data['rsi_6'])
    await exchange.close()

asyncio.get_event_loop().run_until_complete(main(symbol))
