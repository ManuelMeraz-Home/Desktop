[![Build Status](https://travis-ci.com/ManuelMeraz/home.svg?branch=master)](https://travis-ci.com/ManuelMeraz/home)

# home

My linux home directory files and useful scripts. 

I've found myself reinstalling ubuntu on occasion and I improve my `.bashrc`, `.bash_alises` and other scripts over time. This is my way of utilizing version control to improve these files effectively whenever i need to reinstall and set up my home directory.

#### Quick Start

1. Connect to the internet

2. Open a terminal
3. Copy and paste the following into a terminal
 ```
cd ~
wget https://raw.githubusercontent.com/ManuelMeraz/home/master/.scripts/setup_home.sh
chmod +x setup_home.sh
source ./setup_home.sh
```

### Features

#### `.bashrc` 
1. Shows the current branch you're in

![Display git branch in terminal](.images/show_git_branch.png)

2. Appends to history file, and does not overwrite it.
3. Ignores duplicates for commands that are executed repeatedly.
4. Infinite history size for commands
5. Checks the window size after each command, and if necessary, update the values of LINES and COLUMNS
6. Allows the use of `**` in a pathname expansion context and will match all files and zero or more directories and subdirectories
7. Allows cd'ing into a directory without typing in cd
8. Enables `vi` mode in the terminal, allowing to edit terminal commands like `vi`

##### Advanced features enabled by the [.vim](https://github.com/manuelmeraz/.vim) repo 

9. `ctrl+p` uses [ag](https://github.com/ggreer/the_silver_searcher) and [fzf](https://github.com/junegunn/fzf) to search for files, select one, then open it in vim.
10. `ctrl+r` uses [ag](https://github.com/ggreer/the_silver_searcher) and [fzf](https://github.com/junegunn/fzf) to reverse research for previously entered commands

#### `.scripts/project`

This bash script works in conjunction with `.profile`. There are a few environment varibles set by this that are useful, mainly for C/C++ projects. 

1. `WORKSPACE`: Path to a directory where projects are stored (default: `$HOME/projects/`)

2. `PROJECT`: The path 'current' project that you're working on (default:None)

    The `PROJECT` environment variable is set by using the `project` command, which is callable from anywhere. You pass an argument that is the same name as the directory of the project in the `projects` directory. 

    Example:

    `project my_project`

    `WORKSPACE` is now `$HOME/projects/my_project/`

3. `PROJECT_INCLUDE_DIRS`: This environment variable is set alongside `PROJECT` and is an environment variable with all the include directories (directories that contain header files) in the project directory. This variable contains `-isystem` previous to each include directory and can be passed directly as a flag to any C/C++ compiler. I typically use it for `YouCompleteMe` with vim.
