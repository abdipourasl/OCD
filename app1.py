# -*- coding: utf-8 -*-

import tkinter as tk

def check_even_odd():
    # Get the input value from the entry field
    input_value = entry.get()

    try:
        # Attempt to convert the input to an integer
        input_number = int(input_value)

        # Check if the number is even or odd
        if input_number % 2 == 0:
            result_label.config(text="Yes (Even)")
        else:
            result_label.config(text="No (Odd)")
    except ValueError:
        # Handle invalid input (non-integer)
        result_label.config(text="Invalid input (Not a number)")

# Create the main application window
root = tk.Tk()
root.title("Even or Odd Checker")

# Create a label and an entry field for input
input_label = tk.Label(root, text="Enter a number:")
input_label.pack()

entry = tk.Entry(root)
entry.pack()

# Create a button to trigger the check
check_button = tk.Button(root, text="Check", command=check_even_odd)
check_button.pack()

# Create a label to display the result
result_label = tk.Label(root, text="")
result_label.pack()

# Start the GUI event loop
root.mainloop()
