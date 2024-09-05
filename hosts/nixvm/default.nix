{
    inputs,
    config,
    lib,
    pkgs,
    ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ../../disko/btrfs.nix {
      _module.args = {
        disk = "/dev/sda";
      };
    }
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

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system.stateVersion = "24.05";
}