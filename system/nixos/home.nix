{ config, pkgs, inputs, ... }:

{

  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.home-manager.enable = true;
  home.username = "andrabt";
  home.homeDirectory = "/home/andrabt";
  home.stateVersion = "24.05";
  home.file = {};

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };
    # cursorTheme = {
    #  name = "Adwaita";
    #  package = pkgs.adwaita-icon-theme;
    # };    
  };

  fonts.fontconfig.enable = true;

    # configure options
    programs.noctalia-shell = {
      enable = true;
    };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
