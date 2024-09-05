{
    config,
    lib,
    pkgs,
    ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  networking = {
    hostName = "torment";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  time.timeZone = "America/Chicago";

  zramSwap = {
    enable = true;
    memoryMax = 4294967296; # Set max zram swap to 4 GB.
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  system.stateVersion = "24.05";
}