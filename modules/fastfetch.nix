{ config, pkgs, ... }:

let
  fastfetchdir = "/home/oliverk/.config/fastfetch";
  
  fastfetchconf = ''
    "logo": {
      "source": "/etc/nixos/assets/fastfetch/nixos-logo.txt",
      "color": {
        "1": "blue",
        "2": "cyan",
      },
    },
    modules: [
      "title",
      "separator",
      "packages",
      "uptime",
      "cpu",
      "memory",
      "disk",
      "localip",
      "break",
      {
        "type": "colors",
        "symbol": "circle",
      },
    ],
  '';

  in
  {
    system.userActivationScripts.fastfetch = {
	  text = ''
	    mkdir -p ${fastfetchdir}
	    echo '${fastfetchconf}' > ${fastfetchdir}/config.jsonc
    '';
  };
}
