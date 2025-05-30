{ config, pkgs, ... }:

let
  lsddir = "/home/oliverk/.config/lsd";
  lsdconf = ''
    color:
      theme: custom
  '';
  lsdcolors = "/etc/nixos/assets/lsd/colors.yaml";

in
{
  system.userActivationScripts.lsd = {
    text = ''
      mkdir -p ${lsddir}
      echo '${lsdconf}' > ${lsddir}/config.yaml
      cp ${lsdcolors} > ${lsddir}
    '';
  };
}
