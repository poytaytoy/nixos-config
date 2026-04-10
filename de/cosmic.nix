{pkgs, ... }:

{
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    # Replace `yourUserName` with the actual username of user who should be automatically logged in
    user = "poytaytoy";
  };

  services.system76-scheduler.enable = true;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
}