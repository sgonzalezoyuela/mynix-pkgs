{
  description = "JOSSO CTL flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        mypkg = with nixpkgs.legacyPackages.${system}; stdenv.mkDerivation rec {
          pname = "jossoctl";
          version = "v0.5.5";

          src = builtins.fetchTarball {
            url = "https://github.com/atricore/jossoctl-go/archive/refs/tags/v0.5.5.tar.gz";
            sha256 = "12jcqmhlp2g2xpwprfrmarycpksxw9i7xh89i7b6mjkhvbwd10z8";
          };

          buildInputs = [ go ];

          buildPhase = ''
            export GOCACHE=$(mktemp -d)
            go build -o ./jossoctl-go ./jossoctl
          '';

          installPhase = ''
            install -D ./jossoctl-go $out/bin/jossoctl
          '';

          meta = with lib; {
            description = "JOSSO command line tool";
            license = licenses.mit; # Update as needed
          };
        };
      in {
        
        defaultPackage = mypkg;
        packages = {
          jossoctl = mypkg;
        };
      });
}
