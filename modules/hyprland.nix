{ ... }:

let
  hyprlanddir = "/home/oliverk/.config/hypr";
  
  hyprlandconf = ''
    monitor=eDP-1,1366x768@60,0x0,1

    $menu=tofi-drun
  '';

  in
  {
    system.userActivationScripts.hyprland = {
	  text = ''
	    mkdir -p ${hyprlanddir}
	    echo '${hyprlandconf}' > ${hyprlanddir}/hyprland.conf
    '';
  };
}
