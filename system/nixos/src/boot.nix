{ config, pkgs, ... }: {
  # Use GRUB Bootloader
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
  boot.initrd.kernelModules = [];
  boot.kernelParams = [ "radeon.cik_support=0" "amdgpu.cik_support=1" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

