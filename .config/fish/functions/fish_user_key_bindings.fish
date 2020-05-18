function fish_user_key_bindings
  # https://stackoverflow.com/questions/48956984/how-to-remap-escape-insert-mode-to-jk-in-fish-shell
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
end
