# home

My linux home directory files and useful scripts

I've found myself reinstalling ubuntu on occasion and I improve my `.bashrc`, `.bash_alises` and other scripts over time. This is my way of utilizing version control to improve these files effectively. 

### Features

#### My `.bashrc` comes with features that I find useful:
1. Shows the current branch you're in
![Display git branch in terminal](./images/.show_git_branch.png)
2. Appends to history file, and does not overwrite it. Meaning that.
3. Ignores duplicates for commands that are executed repeatedly.
4. Infinite history size for commands
5. Checks the window size after each command, and if necessary, update the values of LINES and COLUMNS
6. Allows the use of `**` in a pathname expansion context and will match all files and zero or more directories and subdirectories
7. Allows cd'ing into a directory without typing in cd
8. Enables `vi` mode in the terminal, allowing to edit terminal commands like `vi`

##### Advanced features enabled by the .vim submodule 

9. `ctrl+p` uses `ag` and `fzf` to search for files, select one, then open it in vim.
10. `ctrl+r` uses `ag` and `fzf` to reverse research for previously entered commands
