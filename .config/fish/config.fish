#! /usr/local/bin/fish

# fish_vi_key_bindings
fish_hybrid_key_bindings

# # Set the cursor shapes for the different vi modes.
set -x fish_cursor_default line
set -x fish_cursor_insert line
set -x fish_cursor_replace_one underscore
set -x fish_cursor_visual block

set fish_color_selection    green

function fish_greeting
  set_color $fish_color_autosuggestion
  uname -nmsr

  command -s uptime >/dev/null
  and command uptime

  fish_logo blue cyan green

  set_color normal
end

function fish_mode_prompt 
end

function fish_prompt

  switch $fish_bind_mode
    case default
      printf '\e]50;CursorShape=0\x7'
      set_color --bold 800000
      printf "[N]"
    case insert
      printf '\e]50;CursorShape=1\x7'
      set_color --bold green
      printf "[I]"
    case replace-one
      printf '\e]50;CursorShape=0\x7'
      set_color --bold green
      printf "[\R]"
    case visual
      printf '\e]50;CursorShape=1\x7'
      set_color --bold brmagenta
      printf "[V]"
  end
  set_color normal

  set_color yellow
  printf " %s" (string replace $HOME '~' $PWD)
  set_color red --bold
  set_color normal
  if string match -q -v "" (git branch ^/dev/null | grep \* | sed 's/* //')
    printf " ["
    set_color magenta
    printf "%s" (git branch ^/dev/null | grep \* | sed 's/* //')
    set_color normal
    printf "]"
  end
  printf "\n"
  printf "%s \$ " (date +"%H:%M")
end

# ABBREVIATIONS
abbr cdr "cd (git rev-parse --show-toplevel)"
abbr gs "git status"

# ALIASES
alias .files "/usr/local/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias lua "lua5.1"
alias marked "open -a /Applications/Marked\ 2.app/" 
alias se "vim (fzf -e --reverse)"
alias sed "gsed"
alias vim "nvim"
alias yt "youtube-dl --add-metadata -i"
alias yta "yt -x -f bestaudio/best"

# AUTOJUMP
begin
  set --local AUTOJUMP_PATH /usr/local/share/autojump/autojump.fish
  if test -e $AUTOJUMP_PATH
    source $AUTOJUMP_PATH
  end
end

# DOCKER ABBREVIATIONS
abbr ddangle "docker images --filter \"dangling=true\" -q"
abbr samld "docker run -it --rm -v \"$HOME/.aws:/aws\" -e \"USER=amack\" -e \"ADFS_DOMAIN=turner\" -e \"ADFS_URL=https://sts.turner.com/adfs/ls/IdpInitiatedSignOn.aspx?loginToRp=urn:amazon:webservices\" turnerlabs/samlkeygen authenticate --all-accounts --auto-update"

# ENVIRONMENT VARIABLES
set -x EDITOR "nvim"

# FUNCTIONS
function make-list
  egrep "^[^ #]*:" ./MakeFile
end

# AWS setup
set -x AWS_PROFILE aws-mssbst-ent:aws-mssbst-ent-admin

# PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /Users/amack/go/bin $PATH
set -x PATH /Users/amack/work/go/bin $PATH
