{ lib, config, pkgs, ... }: {
# Enable KDE Plasma
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6 = {
      enable = true;
    };
  };

  # Include KDE Plasma Apps
  environment.systemPackages = with pkgs.kdePackages; [
    filelight
    kcalc
  ];

  # Exclude KDE Plasma Apps
  environment.plasma6.excludePackages = with pkgs; [];

  # Disable XWayland
  environment.sessionVariables = {
    KWIN_XWAYLAND = "1";
  };

  # Enable KDE Connect
  # programs.kdeconnect = {
  #   enable = true;
  # };

  # Disable some services
  # services.gvfs.enable = false;

  # Optimasi Systemd
  # systemd.services.kde-plasmashell = {
  #   enable = true;
  #   serviceConfig = {
  #     MemoryDenyWriteExecute = true;
  #     NoNewPrivileges = true;
  #     PrivateTmp = true;
  #   };
  # };
}

