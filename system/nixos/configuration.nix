{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./src/boot.nix
      ./src/niri.nix
      ./src/plasma.nix
      ./src/tlp.nix
    ];

  system.stateVersion = "24.05";
 
# Hardware & Filesystems Settings
  # Enable Compression on BTRFS
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ]; 
    "/nix".options = [ "compress=zstd" "noatime" ];
  }; 
  
  # Enable Auto Scrubbing on BTRFS
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
  
  # Enable Graphic
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };
  
  # Enable Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Enable Zram Swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 80;
  };
  
# Network Settings
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };
  services.openssh.enable = true;

# Locale Settings
  services.xserver = {  
    enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb.layout = "us";
    xkb.options = "";
  };
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

# Enable Polkit
  security.polkit.enable = true;

  # Disable TPM
  systemd.tpm2.enable = false;

  # Enable Localsend
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

# Environment Settings
  environment.systemPackages = with pkgs; [
    home-manager
    vim
    git
    git-crypt
    gnupg
    wget
    curl
    gparted
    distrobox
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

# Nix Settings
  # Enable Flakes features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Enable automatic garbage-collection and optimising the store
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nixpkgs.config.allowUnfree = true;
 
# Enable other services
  xdg.portal.enable = true;

  services.flatpak.enable = true;
  services.printing.enable = true;
  
# Users Settings
  users.users.andrabt = {
    isNormalUser = true;
    description = "Andra Berlianto Tedja";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "video" ];
  };

# Virtualisation
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
    podman.dockerCompat = true;
  };
}

