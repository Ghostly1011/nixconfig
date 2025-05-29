{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{
  imports =
    [
      ./hardware-configuration.nix # Include automatic hardware configuration.
      (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  # Select locale properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    helix # Modal text editor.
    git
    fastfetch
  ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland.enable = true;  

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.bash.interactiveShellInit = "exec fish";
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = "fastfetch";
  programs.fish.shellAliases = {
    rebuild = /etc/nixos/rebuild.fish;
  };

  programs.starship.enable = true;
  programs.starship.presets = [ "nerd-font-symbols' "];

  users.users.oliverk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  home-manager.users.oliverk = {
    programs.starship.enable = true;
    programs.fastfetch.enable = true;
    programs.fastfetch.settings = {
      logo = {
        source = "/etc/nixos/fastfetch-logo.txt";
        color = {
          "1" = "blue";
          "2" = "cyan";
        };
      };
      modules = [
        "title"
        "separator"
        "packages"
        "uptime"
        "cpu"
        "memory"
        "disk"
        "localip"
        "break"
        {
          type = "colors";
          symbol = "circle";
        }
      ];
    };
    programs.kitty.enable = true;
    programs.kitty.shellIntegration.enableFishIntegration = true;
    programs.kitty.font = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
      size = 12;
    };

    programs.firefox.enable = true;

    home.stateVersion = "25.05"; # Do not change.
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

