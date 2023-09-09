{
  description = "DEV tools (Josso/IAM.tf)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        jossoctl-pkg = import ./jossoctl {
          inherit nixpkgs system;
        };

        iamtfctl-pkg = import ./iamtfctl {
          inherit nixpkgs system;
        };
      
      in {
        
        defaultPackage = jossoctl-pkg;
        
        packages = {
          jossoctl = jossoctl-pkg;
          iamtfctl = iamtfctl-pkg;
        };
      });
}
