# Devtools

## Sublime Text Macros

### Surround with quotes and separate by comma in the same line
This macro allow you to easily wrap lines of text in single quotes, puts them in the same line, separated by a comma, and copies it to your clipboard - very handy when needing to prepare a set of database IDs to be used on a second query. 

![Wrap in single quotes](https://github.com/rafaeloliveira1337/devtools/blob/img/img/wrap-in-quotes.gif)

### Surround with double quotes and separate by comma
This macro allow you to easily wrap lines of text in double quotes and adds a comma in the end of the line, and also copies it to the clipboard.

![Wrap in double quotes](https://github.com/rafaeloliveira1337/devtools/blob/img/img/wrap-in-double-quotes.gif)

### How to set up (OSX)

- Copy the macro files in [sublime-text-macros](./sublime-text-macros) folder into `/Users/<username>/Library/Application Support/Sublime Text 3/Packages/User`

- Open your key binding configuration file by going to `Preferences`, `Key Bindings` and add this code to your `keymap - User` configuration file to map a key combination to trigger each macro:
```json
[
    { "keys": ["super+shift+,"], "command": "run_macro_file", "args": {"file": "res://Packages/User/surround-with-quotes.sublime-macro"} }
    { "keys": ["super+shift+."], "command": "run_macro_file", "args": {"file": "res://Packages/User/surround-with-double-quotes.sublime-macro"} }
]
```

Notes: 
- `"super"` is the command key on mac, or the windows key on PC.
- if the macro behaves in an odd way, try changing the `word wrap` setting of the file you're working on.


## Bash Scripts

### Findr
Finds the number of occurrences of a string in all files of a specific extension in a folder and its subfolders. The output is the number of occurrences and the filename where occurrences were found.

Use case: useful when you have a configuration project with many config files and need to change a reference (e.g. if something was renamed).

### Usage
You can copy the `findr.sh` script to your local machine and set up an alias on your `.zshrc`/`.bashrc`:
```
alias findr='sh path/to/findr.sh'
```

Then you can execute it with this syntax:
```
findr <extension> <string to search for> <optional: path to a folder where the look up should happen>
```
Example: to find all occurences of `printf` on `.sh` files on this repository's folder:
```
$ findr sh printf
       4 ./bash-scripts/findr.sh

Total files checked: 1
Found 'printf' in 1 files.
```


## Quality Certificate
<img src="https://github.com/rafaeloliveira1337/devtools/blob/img/img/works_on_my_machine.png" width="350" alt="Works on my machine" /> ![Kitty](https://github.com/rafaeloliveira1337/devtools/blob/img/img/kitty_paws.gif)

