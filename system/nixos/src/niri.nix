{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
  ];

  programs.niri = {
    enable = true;
  };

  programs.dankMaterialShell = {
    enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "gtk3";
  }; 

  environment.systemPackages = with pkgs; [
    alacritty
    pwvucontrol
    quickshell
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
  programs.xfconf.enable = true;
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

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

}
