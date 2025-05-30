{ ... }:

let
  helixdir = "/home/oliverk/.config/helix";
  helixconf = ''
    theme = "catppuccin_mocha"

    [editor]
    line-number = "relative"
    cursorline = true
    color-modes = true

    [editor.cursor-shape]
    insert = "bar"
    select = "underline"
  '';
in
{
  system.userActivationScripts.helix = {
    text = ''
      mkdir -p ${helixdir}
      echo '${helixconf}' > ${helixdir}/config.toml
    '';
  };
}
