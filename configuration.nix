{ config, pkgs, ... }:

{
  FOLDER = "sys";

  imports =
    [
      ./${FOLDER}/hardware-configuration.nix
      ./${FOLDER}/nvidia.nix 
      ./${FOLDER}/stylix.nix 
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.poytaytoy = {
    isNormalUser = true;
    description = "Clement";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    packages = with pkgs; [
    steam 
    steam-unwrapped 
    ];
      subGidRanges = [
          {
              count = 65536;
              startGid = 10000;
          }
      ];
      subUidRanges = [
          {
              count = 65536;
              startUid = 10000;
          }
      ];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.podman = {
  enable = true;
  dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
  vim 
  distrobox 
  ];

  programs.bash.completion.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
    localNetworkGameTransfers.openFirewall = true; 
  };

  programs.firefox.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  system.stateVersion = "25.11"; 
  }