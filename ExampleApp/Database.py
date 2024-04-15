from PySide6.QtCore import QObject, Slot
from PySide6.QtSql import QSqlDatabase, QSqlQuery

# from Thread import AccountInfo

class Database(QObject):
    conn: str = ""

    def __init__(self, c: str):
        QObject.__init__(self)
        self.connectDB
        self.conn = c

    @Slot()
    def connectDB(self):
        db = QSqlDatabase.addDatabase("QSQLITE", self.conn)
        db.setDatabaseName("account_info.db")
        db.open()
        print("DB:", db.isOpen())

    @Slot()
    def disconnectDB(self):
        db = QSqlDatabase.database(self.conn)
        if db.isOpen():
            db.close()

    @Slot(result=list)
    def accounts_get(self):
        db = QSqlDatabase.database(self.conn)
        try:
            res: list = []
            qstr = "SELECT `name`, `type`, `api`, `secret` FROM Accounts"
            query = QSqlQuery(qstr, db)
            while query.next():
                d = {
                'name':query.value(0),
                'type':query.value(1),
                'api':query.value(2),
                'key':query.value(3),
                'check':0
                }
                res.append(d)

            return res


        except Exception as e:
            print("Error", e)
            return []

    @Slot(str)
    def accounts_delete(self, name:str):
        db = QSqlDatabase.database(self.conn)
        if db.isOpen():
            qstr = "DELETE FROM Accounts WHERE Accounts.name = \'{}\'".format(name)
            query = QSqlQuery(qstr, db)
            query.exec()

    @Slot(dict, result=bool)
    def account_save(self, card:dict):
        db = QSqlDatabase.database(self.conn)
        if db.isOpen():
            qstr = "INSERT INTO Accounts (name, type, api, secret) values(?, ?, ?, ?)"
            query = QSqlQuery(qstr, db)
            query.bindValue(0, card.get('name'))
            query.bindValue(1, card.get('type'))
            query.bindValue(2, card.get('api'))
            query.bindValue(3, card.get('key'))
            return query.exec()
