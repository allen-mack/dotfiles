# Enable colors and change prompt:
autoload -U colors && colors

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000

# Basic auto/tab complete
# To make this work, I had to run these commands:
# sudo chmod -R 755 /usr/local/share/zsh
# sudo chown -R root:staff /usr/local/share/zsh
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # Include hidden files.

# # vi mode
# bindkey -v
# export KEYTIMEOUT=1
#
# # Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '?' backward-delete-char

# ZSH VI MOODE 
# https://github.com/jeffreytse/zsh-vi-mode
ZVM_VI_ESCAPE_BINDKEY=jk

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    return '- ('$branch')'
  fi
}

function zvm_after_select_vi_mode() {
  # Display the current VI mode
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      CURRENT_VI_MODE=$fg[red][N]
    ;;
    $ZVM_MODE_INSERT)
      CURRENT_VI_MODE=$fg[green][I]
    ;;
    $ZVM_MODE_VISUAL)
      CURRENT_VI_MODE=$fg[purple][V]
    ;;
    $ZVM_MODE_VISUAL_LINE)
      CURRENT_VI_MODE=$fg[purple][VL]
    ;;
  esac

  # Display GIT branch info.
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    formattedbranch=''
  else
    formattedbranch=[${fg[magenta]}$branch$reset_color]
  fi
  NEWLINE=$'\n'
  PROMPT="%B$CURRENT_VI_MODE%b %{$fg[yellow]%}%~%{$reset_color%} ${formattedbranch}${NEWLINE}%D{%L:%M} $ "
}

clear
# cat < ~/.config/zsh/skull ;
neofetch

# ALIASES
alias vim="nvim"

# VI MODE PLUGIN
# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
source $HOME/.config/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

# ZSH-AUTOSUGGESTIONS
# Installed with HomeBrew on Macs
# https://github.com/zsh-users/zsh-autosuggestions 
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting. Should be the last line in the file.
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
