#!/sbin/python
import ccxt
import os
import re
import time
import pandas as pd

from stockstats import StockDataFrame as Sdf

def get_historical_data(coin_pair, timeframe):
    """Get Historical data (ohlcv) from a coin_pair
    """
    # optional: exchange.fetch_ohlcv(coin_pair, '1h', since)
    data = exchange.fetch_ohlcv(coin_pair, timeframe)
    # update timestamp to human readable timestamp
    data = [[exchange.iso8601(candle[0])] + candle[1:] for candle in data]
    header = ['Timestamp', 'Open', 'High', 'Low', 'Close', 'Volume']
    df = pd.DataFrame(data, columns=header)
    return df


def create_stock(historical_data):
    """Create StockData from historical data
    """
    stock  = Sdf.retype(historical_data)
    return stock


if __name__ == "__main__":
  ...
  for coin_pair in valid_coin_pairs:
    # respect rate limit
    time.sleep (exchange.rateLimit / 1000)
    data = get_historical_data(coin_pair, '1h')
    stock_data = create_stock(data)
