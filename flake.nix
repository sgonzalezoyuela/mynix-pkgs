{
  description = "JOSSO CTL flake";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    jossoctl-pkg.url = "path:./jossoctl";
  };

  outputs = { self, flake-utils, jossoctl-pkg }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        jossoctl = jossoctl-pkg.defaultPackage.${system};
      in {
        packages = { inherit jossoctl; };        
      });
}
