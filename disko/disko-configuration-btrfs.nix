# Partition Layout
#
# /boot - FAT32 - 1G
# swap - 8G
# volume - BTRFS - Rest of Disk
#   /root - Subvol - /
#   /home - Subvol - /home
#   /nix - Subvol - /nix
#
{
  disko.devices = {
    disk.sda = {
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
            };
          };
          swap = {
            size = "8G";
            content = {
              type = "swap";

            };
          };
          volume = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Override existing partition
              subvolumes = {
                # Root subvolume
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress-force=zstd:1" "noatime" ];
                };
                # Home subvolume
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress-force=zstd:1" "noatime" ];
                };
                # Nix subvolume
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress-force=zstd:1" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
