import tkinter as tk
from tkinter import filedialog

# Function to check if the content of the selected file is even or odd
def check_file_content():
    file_path = filedialog.askopenfilename()
    if not file_path:
        return

    try:
        with open(file_path, 'r') as file:
            content = file.read().strip()
            try:
                number = int(content)
                result = "Yes (Even)" if number % 2 == 0 else "No (Odd)"
                result_label.config(text=result)
            except ValueError:
                result_label.config(text="Invalid content (Not a number)")
    except FileNotFoundError:
        result_label.config(text="File not found")

# Create the main application window
root = tk.Tk()
root.title("Even or Odd Checker (File Input)")

# Create a button to select a file
file_button = tk.Button(root, text="Select a File", command=check_file_content)
file_button.pack()

# Create a label to display the result
result_label = tk.Label(root, text="")
result_label.pack()

# Start the GUI event loop
root.mainloop()
