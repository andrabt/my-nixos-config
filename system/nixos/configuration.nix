{ config, pkgs, lib, inputs, ... }:

{
  imports = [ 
      ./hardware-configuration.nix
      ./src/niri.nix
  ];

  system.stateVersion = "24.05";

# ++++++++++++++++++++++++

# Boot
  # Use GRUB
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    memtest86.enable = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # Boot Extra Kernel Module
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ 
    "zswap.enabled=1" 
    "zswap.compressor=zstd" 
    "zswap.max_pool_percent=20" 
    "zswap.shrinker_enabled=1" 
    "radeon.cik_support=0" 
    "amdgpu.cik_support=1" 
  ];

#++++++++++++++++++++++++

# Hardware & Filesystems Settings
  # Enable Compression on BTRFS
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NixOS";
      options = [ "compress=zstd" ];
    };
    "/home" = { 
      device = "/dev/disk/by-label/NixOS";
      options = [ "compress=zstd" ];
    }; 
    "/nix" = {
      device = "/dev/disk/by-label/NixOS";
      options = [ "compress=zstd" "noatime" ];
    };
  }; 
  
  # Enable Auto Scrubbing on BTRFS
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
 
  # Enable Swap Device
  swapDevices = [ {
    device = "/dev/disk/by-label/swap";
  } ];  
 
  # Enable Graphic
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  # Enable Sound
  hardware.bluetooth.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Touchpad
  services.libinput.enable = true;

# ++++++++++++++++++++++

# Network Settings
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };
  services.openssh.enable = true;

# ++++++++++++++++++++++

# Locale Settings;
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Polkit
  security.polkit.enable = true;

  # Disable systemd service by default
  systemd.services.libvirtd.wantedBy = lib.mkForce [];
  systemd.services.libvirt-guests.wantedBy = lib.mkForce [];

# ++++++++++++++++++++++

# Environment Settings
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    libreoffice
    onlyoffice-desktopeditors
    vim
    wget
    curl
    gparted
    exfatprogs
    gvfs
    distrobox
    yazi
    bitwarden-desktop
    localsend
    logseq
    notesnook
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
    gh
    quickshell
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

# ++++++++++++++++++++++++

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
  nix.settings.trusted-users = [ "root" "andrabt" ];
  nixpkgs.config.allowUnfree = true;

# ++++++++++++++++++++++++

# Enable Power Management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;
  services.system76-scheduler = {
    enable = true;
    settings.cfsProfiles.enable = true;
  };

  hardware.system76.power-daemon.enable = true;

  # Power Button and Laptop Behaviour
  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    HandleLidSwitch = "suspend";
  };
  
# ++++++++++++++++++++++++

# Other Services
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.gvfs.enable = true;
  systemd.tpm2.enable = false;

# ++++++++++++++++++++++++

# Users Settings
  users.users.andrabt = {
    isNormalUser = true;
    description = "Andra Berlianto Tedja";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "video" ];
    packages = with pkgs; [
      adwaita-icon-theme
      papirus-icon-theme
    ];
  };

  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
           icon-theme = "Papirus";
           cursor-theme = "Adwaita";
        };
      };
    }];
  };


# ++++++++++++++++++++++++

# Virtualisation
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
    podman.dockerCompat = true;
  };
}
