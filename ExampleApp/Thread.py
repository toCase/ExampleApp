# This Python file uses the following encoding: utf-8
from PySide6.QtCore import QThread, Signal, Slot

from pybit.unified_trading import HTTP
from binance import Client
from binance.exceptions import BinanceAPIException

from Database import Database
import time


class AccountInfo(QThread):
    data:list = []

    db = Database("ai")


    fail = Signal(str, arguments=['message'])
    working = Signal(float, arguments=['val'])

    def __init__(self):
        QThread.__init__(self)

    @Slot(list)
    def data_set(self, d:list):
        self.data = d

    @Slot(result=list)
    def data_get(self):
        return self.data

    @Slot()
    def run(self):
        # print("START")
        # self.started.emit()

        self.db.connectDB()
        self.data = self.db.accounts_get()

        # print("DATA:", self.data)

        if self.data:
            x: int = 0
            for card in self.data:
                server = card.get('type')
                if server == "bybit":
                    try:
                        connection = HTTP(
                            testnet=False,
                            api_key=card.get('api'),
                            api_secret=card.get('key'),
                        )
                        # print("ACC:", connection.get_account_info())
                        result = connection.get_wallet_balance(accountType='SPOT', coin='USDT').get('result')
                        balance = result.get('list')[0].get('coin')[0].get('walletBalance')
                        card['balance'] = balance
                    except Exception as e:
                        print("ERROR:", e)
                        card['balance'] = 'ERR'

                elif server == "binance":
                    try:
                        connection = Client(
                            testnet=False,
                            api_key=card.get('api'),
                            api_secret=card.get('key'),
                            )
                        ballances = connection.get_account().get('balances')
                        for bal in ballances:
                            if bal['asset'] == 'USDT':
                                card['balance'] = bal.get('free')
                    except BinanceAPIException as e:
                        print("ERR_status: ", e.status_code)
                        print("ERR_message: ", e.message)
                        card['balance'] = 'ERR'
                else:
                    card['balance'] = 'ERR'

                self.data[x] = card
                # print(card)

                x = x + 1
                progress = x / len(self.data)
                self.working.emit(progress)
                # time.sleep(0.3)
        # print(self.data)
        # self.finished.emit()




