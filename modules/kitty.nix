{ config, pkgs, ... }:

let
  kittydir = "/home/oliverk/.config/kitty";
  kittyconf = ''
    font_family FiraCode Nerd Font
    font_size 12
  '';
in
{
  system.userActivationScripts.kitty = {
    text = ''
      mkdir -p ${kittydir}
      echo '${kittyconf}' > ${kittydir}/kitty.conf
    '';
  };
}
