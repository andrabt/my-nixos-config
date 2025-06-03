{ config, pkgs, ... }:
{
  programs.niri = {
    enable = true;
  };
  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  }; 

  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    calcurse
    cliphist
    libnotify
    mako
    pwvucontrol
    polkit_gnome
    swaybg
    swayidle
    swaylock
    tofi
    waybar
    wl-clipboard
    wf-recorder
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xwayland-satellite
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

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

}
