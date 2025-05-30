{ config, pkgs, ... }:

let
  batdir = "/home/oliverk/.config/bat";
  batconf = ''
    --theme="Catppuccin Mocha"
  '';
  batthemes = "/etc/nixos/assets/bat/themes";

in
{
  system.userActivationScripts.bat = {
    text = ''
      mkdir -p ${batdir}
      echo '${batconf}' > ${batdir}/config
      cp -r ${batthemes} ${batdir}/themes
    '';
  };
}
