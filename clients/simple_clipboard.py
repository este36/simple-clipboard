import time
import pyperclip
import requests

last = ""
while True:
    time.sleep(1)
    tmp = requests.get("http://localhost:5000")
    if last != tmp.text:
        pyperclip.copy(tmp.text)
        last = tmp.text
