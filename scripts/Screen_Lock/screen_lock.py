import os
import sys
import subprocess
import hashlib
import random
from datetime import datetime
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QGridLayout, QVBoxLayout, QLabel
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QColor, QPalette

GRID_SIZE = 4
CORRECT_HASH = "cd6e8ebb5168d8886a502892ceb7e346"
n=0

class PatternLock(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Pattern Lock")
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint)
        self.showFullScreen()

        palette = self.palette()
        palette.setColor(QPalette.Window, QColor("black"))
        self.setPalette(palette)

        self.pattern = []
        self.buttons = []
        self.highlight_timers = []

        layout = QVBoxLayout()
        self.setLayout(layout)

        grid_widget = QWidget()
        grid_widget.setMaximumSize(800, 800)
        grid = QGridLayout()
        grid_widget.setLayout(grid)

        self.datetime_label = QLabel()
        self.datetime_label.setStyleSheet("color: white; font-size: 18px;")
        self.datetime_label.setAlignment(Qt.AlignCenter)
        self.datetime_label.setMaximumHeight(50)

        self.timer = QTimer()
        self.timer.timeout.connect(self.update_datetime)
        self.timer.start(1000)
        self.update_datetime()

        layout.addWidget(self.datetime_label)
        layout.addWidget(grid_widget, alignment=Qt.AlignCenter)
        
        for i in range(GRID_SIZE * GRID_SIZE):
            btn = QPushButton("")
            btn.setFixedSize(180, 180)
            btn.setStyleSheet("""
                background-color: #D8CAB8;
                border-radius: 20px;
                color: white;
            """)
            btn.clicked.connect(lambda _, idx=i: self.on_button_clicked(idx))
            self.buttons.append(btn)
            grid.addWidget(btn, i // GRID_SIZE, i % GRID_SIZE)

    def update_datetime(self):
        now = datetime.now()
        self.datetime_label.setText(now.strftime("%A, %d %B %Y - %H:%M:%S"))
    
    def on_button_clicked(self, index):
        n = random.randint(0, GRID_SIZE * GRID_SIZE - 1)
        self.buttons[n].setStyleSheet("background-color: #1793D1; border-radius: 20px; color: white;")
        
        timer = QTimer(self)
        timer.setSingleShot(True)
        timer.timeout.connect(lambda b=self.buttons[n]: b.setStyleSheet("background-color: #D8CAB8; border-radius: 20px; color: white;"))
        timer.start(500)


        self.highlight_timers.append(timer)
        n = random.randint(0, GRID_SIZE * GRID_SIZE - 1)
        self.buttons[n].setStyleSheet("background-color: #1793D1; border-radius: 20px; color: white;")

        timer = QTimer(self)
        timer.setSingleShot(True)
        timer.timeout.connect(lambda b=self.buttons[n]: b.setStyleSheet("background-color: #D8CAB8; border-radius: 20px; color: white;"))
        timer.start(500)

        self.pattern.append(index)
        self.highlight_timers.append(timer)

        if len(self.pattern) >= 5:
            self.check_pattern()

    def check_pattern(self):
        pattern_str = ''.join(map(str, self.pattern))
        hashed = hashlib.md5(pattern_str.encode()).hexdigest()
        if hashed == CORRECT_HASH:
            self.close()
        else:
            self.flash_red()

    def clear_pattern(self):
        self.pattern = []
        for btn in self.buttons:
            btn.setEnabled(True)
            btn.setStyleSheet("""
                background-color: #D8CAB8;
                border-radius: 20px;
                color: white;
            """)

    def flash_red(self):
        for t in self.highlight_timers:
            t.stop()
        self.highlight_timers.clear()
        for btn in self.buttons:
            btn.setDisabled(True)
            btn.setStyleSheet("background-color: #D8CAB8; border-radius: 10px;")
        QTimer.singleShot(1000, self.clear_pattern)

if __name__ == "__main__":
   
    os.environ["QT_QPA_PLATFORM"] = "wayland"
    app = QApplication(sys.argv)
    window = PatternLock()
    window.show()

    if len(sys.argv) == 1:
        subprocess.Popen("""
        wlr-randr --output DSI-1 --off;
        """, shell=True)
    print(len(sys.argv))

    subprocess.Popen("""
    swayidle -w timeout 10 'wlr-randr --output DSI-1 --off'
    """, shell=True)

    sys.exit(app.exec_())
    
    
