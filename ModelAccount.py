# This Python file uses the following encoding: utf-8
from PySide6.QtCore import Qt, QObject, QAbstractListModel, QModelIndex, Slot, Signal
from Database import Database
from Thread import AccountInfo

class ModelAccount(QAbstractListModel):

    data_map=[]

    ai = AccountInfo()
    db = Database("ma")

    col1 = Qt.UserRole + 1
    col2 = Qt.UserRole + 2
    col3 = Qt.UserRole + 3
    col4 = Qt.UserRole + 4
    col5 = Qt.UserRole + 5
    col6 = Qt.UserRole + 6
    col7 = Qt.UserRole + 7

    started = Signal()
    finished = Signal()
    working = Signal(float, arguments=['val'])



    def __init__(self, parent=None):
        super().__init__(parent)
        self.db.connectDB()

        self.ai.finished.connect(self.loadModel)
        self.ai.working.connect(self.working)
        self.ai.started.connect(self.started)
        self.ai.finished.connect(self.finished)


    @Slot()
    def loadData(self):
        self.ai.start()

    @Slot()
    def loadModel(self):
        print("LOAD MODEL")
        self.beginResetModel()

        self.data_map.clear()
        self.data_map = self.ai.data_get()

        print("DATA:", self.data_map)

        self.endResetModel()

    def rowCount(self, parent=QModelIndex):
        return len(self.data_map)

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if index.isValid():
            card = self.data_map[row]
            if role == self.col1:
                return card.get("name")
            if role == self.col2:
                return card.get("type")
            if role == self.col3:
                return card.get("api")
            if role == self.col4:
                return card.get("key")
            if role == self.col5:
                return card.get("check")
            if role == self.col6:
                if card.get("balance") == "ERR":
                    return "Not valid"
                else:
                    return "Active"
            if role == self.col7:
                if card.get("balance") == "ERR":
                    return ""
                else:
                    return card.get("balance")

    def roleNames(self):
        return {
            self.col1: b"name",
            self.col2: b"type",
            self.col3: b"api",
            self.col4: b"key",
            self.col5: b"check",
            self.col6: b"status",
            self.col7: b"balance",
            }

    @Slot()
    def selectAll(self):
        self.beginResetModel()
        x :int = 0
        for card in self.data_map:
            if card.get("balance") == "ERR":
                card['check'] = 0
            else:
                card['check'] = 1
            self.data_map[x] = card
            x = x + 1

        self.endResetModel()

    @Slot()
    def closeAll(self):
        self.beginResetModel()
        x :int = 0
        for card in self.data_map:
            card['check'] = 0
            self.data_map[x] = card
            x = x + 1
        self.endResetModel()

    @Slot(int)
    def deleteAccount(self, index:int):
        self.beginResetModel()

        card = self.data_map[index]
        self.data_map.pop(index)
        self.db.accounts_delete(card.get('name'))

        self.endResetModel()

    @Slot(list)
    def add(self, l:list):
        card = {
            'name':l[0],
            'type':l[1],
            'api':l[2],
            'key':l[3]
        }
        if self.db.account_save(card):
            self.loadData()

