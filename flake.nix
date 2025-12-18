{
  description = "Cloudflared (latest) overlay + NixOS module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
  let
    overlays = {
      default = import ./overlays/default.nix;
    };
  in
  {
    inherit overlays;

    nixosModules.cloudflared = import ./modules/nixos/cloudflared.nix;
  }
  // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlays.default ];
      };
    in {
      packages.cloudflared-bin = pkgs.cloudflared-bin;
    }
  );
}

