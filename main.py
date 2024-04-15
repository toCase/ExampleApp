# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import Database
import ModelAccount


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    # database = Database.Database()
    # engine.rootContext().setContextProperty("database", database)

    modelAccount = ModelAccount.ModelAccount()
    engine.rootContext().setContextProperty("modelAccount", modelAccount)



    qml_file = Path(__file__).resolve().parent / "qml/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
