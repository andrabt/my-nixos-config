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
    onlyoffice-desktopeditors
    yazi
    bitwarden-desktop
    mpv
    zoxide
    file
    glow
    mediainfo
    exiftool
    p7zip
    fastfetch
    htop
    git
    git-crypt
    gnupg
    pinentry-qt
    gh    
  ];
  
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };    
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  # Bash
  programs.bash = {
    enable = true;
    bashrcExtra = "";
  };

  targets.genericLinux.enable = true;

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
    userEmail = "168298570+andrabt@users.noreply.github.com";
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
