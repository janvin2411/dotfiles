#!/usr/bin/env python

# coding:utf8

from __future__ import print_function

import requests
import os
import sys

FIAT = 'CNY'
PRICE_FIAT = 'price_{}'.format(FIAT.lower())
PRICE_BTC = 'price_btc'
PRICE_USD = 'price_usd'

class CCAsset:
    def __init__(self, coin_id, num, fiat, usd, btc):
        self.coin_id = coin_id
        self.num = num
        self.btc = btc
        self.fiat = fiat
        self.usd = usd

    def __str__(self):
        if FIAT == 'USD':
            return "{:<20} {:>10.2f}, {:>14.6f} {}, {:>16.8f} BTC".format(
                self.coin_id, self.num, self.fiat, FIAT, self.btc)
        else:
            return "{:<20} {:>10.2f}, {:>14.6f} {}, {:>14.6f} USD, {:>16.8f} BTC".format(
                self.coin_id, self.num, self.fiat, FIAT, self.usd, self.btc)

    def all_fiat(self):
        return self.num * self.fiat

    def all_usd(self):
        return self.num * self.usd

    def all_btc(self):
        return self.num * self.btc


def cmc_req(ticker, convert):
    url = 'https://api.coinmarketcap.com/v1/ticker/{}/?convert={}'.format(ticker, convert)
    req = requests.get(url)
    req_json = req.json()[0]
    return req_json


def cc_assets(asset_fpath):
    cc_info = []
    with open(asset_fpath) as asset_file:
        for line in asset_file:
            if line.startswith('#'):
                print("[ignore] {}".format(line))
                continue
            columns = line.split()
            ticker = columns[0]
            num = float(columns[1])
            req_json = cmc_req(ticker, FIAT)
            price_fiat = float(req_json[PRICE_FIAT])
            price_usd = float(req_json[PRICE_USD])
            price_btc = float(req_json[PRICE_BTC])
            cc = CCAsset(ticker, num, price_fiat, price_usd, price_btc)
            print(cc)
            cc_info.append(cc)
    return cc_info


if __name__ == "__main__":
    if len(sys.argv) >= 2:
        input_file = sys.argv[1]
    else:
        input_file = os.path.expanduser('~/tools/private/cc.txt')
    if not os.path.exists(input_file):
        print('{} not exists!'.format(input_file), file=sys.stderr)
        sys.exit(1)
    all_cc = cc_assets(input_file)
    print()
    all_fiat = 0
    all_usd = 0
    all_btc = 0
    for cc in all_cc:
        cc_fiat = cc.all_fiat()
        cc_btc = cc.all_btc()
        cc_usd = cc.all_usd()
        all_btc += cc_btc
        all_fiat += cc_fiat
        all_usd += cc_usd
        if FIAT == 'USD':
            print("{:<20} {:>10.2f} {}{:>16.8f} BTC".format(cc.coin_id, cc_fiat, FIAT, cc_btc))
        else:
            print("{:<20} {:>10.2f} {}, {:>10.2f} USD, {:>16.8f} BTC".format(cc.coin_id, cc_fiat, FIAT, cc_usd, cc_btc))
    print()
    if FIAT == 'USD':
        print("Total: {} {},  {} BTC".format(all_fiat, FIAT, all_btc))
    else:
        print("Total: {} {}, {} USD,  {} BTC".format(all_fiat, FIAT, all_usd, all_btc))