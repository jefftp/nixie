{
  description = "Nixie - Flaming Hot NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    disko,
    nixpkgs,
    ...
  } @ inputs:
  let
    system = "x86_64-linux";
    host = "torment";
  in {
    nixosConfigurations = {
      torment = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit host;
        };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
