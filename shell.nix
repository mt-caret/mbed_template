{}:

let
  pkgs = import <nixpkgs> { };
in with pkgs; {
  mbedEnv = stdenv.mkDerivation {
    name = "mbed";
    buildInputs = [
      gcc-arm-embedded
      git
      mercurial
      gnumake
      (pkgs.python27.withPackages (ps: [
        ps.prettytable
        ps.jinja2
        ps.colorama
        (ps.buildPythonPackage rec {
          name = "mbed-cli-${version}";
          version = "1.1.1";

          src = pkgs.fetchurl {
            url = "https://github.com/ARMmbed/mbed-cli/archive/${version}.zip";
            sha256 = "1hxp649hfpkw33i5h4yhcm0hbd5mzj8rj0i5kd9534yrsx3glba6";
          };

          meta = {
            homepage = "https://github.com/ARMmbed/mbed-cli";
            description = "ARM mbed Command Line Interface";
            license = licenses.asl20;
          };
        })
      ]))
    ];
  };
}
