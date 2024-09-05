# Partition Layout
#
# /boot - FAT32 - 1G
# volume - BTRFS - Rest of Disk
#   /root - Subvol - /
#   /home - Subvol - /home
#   /nix - Subvol - /nix
#
{
  disko.devices = {
    disk = {
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            # Set up the EFI Startup Partition
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Force overwriting any existing partition
                subvolumes = {
                  # Root subvolume
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress-force=zstd:1"
                      "noatime"
                    ];
                  };
                  # Home subvolume
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress-force=zstd:1"
                      "noatime"
                    ];
                  };
                  # Nix subvolume
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress-force=zstd:1"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
