# Setup fzf
# ---------
if [[ ! "$PATH" == */home/manny/.vim/bundle/fzf/bin* ]]; then
  export PATH="$PATH:/home/manny/.vim/bundle/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/manny/.vim/bundle/fzf/man* && -d "/home/manny/.vim/bundle/fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/manny/.vim/bundle/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/manny/.vim/bundle/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/manny/.vim/bundle/fzf/shell/key-bindings.bash"

