{ nixpkgs, system }:

with nixpkgs.legacyPackages.${system}; stdenv.mkDerivation rec {
  pname = "iamtfctl";
  version = "v0.5.5";

  src = builtins.fetchTarball {
    url = "https://github.com/atricore/jossoctl-go/archive/refs/tags/v0.5.5.tar.gz";
    sha256 = "12jcqmhlp2g2xpwprfrmarycpksxw9i7xh89i7b6mjkhvbwd10z8";
  };

  buildInputs = [ go ];

  buildPhase = ''
    export GOCACHE=$(mktemp -d)
    go build -ldflags="-X 'main.version=${version}'" -o ./iamtfctl-go ./iamtfctl
  '';

  installPhase = ''
    install -D ./iamtfctl-go $out/bin/iamtfctl
  '';

  meta = with lib; {
    description = "IAM.tf command line tool";
    license = licenses.mit; # Update as needed
  };
}
