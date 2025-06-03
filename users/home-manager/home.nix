{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.username = "andrabt";
  home.homeDirectory = "/home/andrabt";
  home.stateVersion = "24.05";
  home.file = {};

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
    firefox
    thunderbird
    libreoffice-qt6
    yazi
    mpv
    zoxide
    file
    glow
    p7zip
    fastfetch
    htop
    git
    git-crypt
    gnupg
    pinentry-qt    
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  # Git
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "vim";
      credential.helper = "store";
      github.user = "andrabt";
      push.autoSetupRemote = true;
    };
    userEmail = "aloysiusandra@gmail.com";
    userName = "andrabt";
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent.enable = true;

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

}
