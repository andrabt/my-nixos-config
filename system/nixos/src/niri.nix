{ config, pkgs, ... }:
{

  programs.niri = {
    enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  }; 

  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    calcurse
    cliphist
    copyq
    fuzzel
    libnotify
    mako
    polkit_gnome
    pwvucontrol
    swayidle
    swaylock
    waybar
    wbg
    wl-clipboard
    wf-recorder
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xfce.mousepad
    xfce.orage
    xfce.tumbler
    xreader
    xviewer
    xwayland-satellite
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # Enable Thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ 
      thunar-archive-plugin
      thunar-dropbox-plugin
      thunar-media-tags-plugin
      thunar-vcs-plugin 
      thunar-volman 
    ];
  };

  programs.file-roller.enable = true;

  # Enable GDM as Display Manager for Niri
  services.displayManager.gdm.enable = true;

  # Enable Polkit 
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Enable Localsend
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

}
