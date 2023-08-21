{ nixpkgs, system }:

with nixpkgs.legacyPackages.${system}; stdenv.mkDerivation rec {
  pname = "jossoctl";
  version = "v0.5.5";

  src = builtins.fetchTarball {
    url = "https://github.com/atricore/jossoctl-go/archive/refs/tags/${version}.tar.gz";
    sha256 = "12jcqmhlp2g2xpwprfrmarycpksxw9i7xh89i7b6mjkhvbwd10z8";
  };

  buildInputs = [ go ];

  buildPhase = ''
    export GOCACHE=$(mktemp -d)
    go build -ldflags="-X 'main.version=${version}'" -o ./jossoctl-go ./jossoctl
  '';

  installPhase = ''
    install -D ./jossoctl-go $out/bin/jossoctl
  '';

  meta = with lib; {
    description = "JOSSO command line tool";
    license = licenses.mit; # Update as needed
  };
}
