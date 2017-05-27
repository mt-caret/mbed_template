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
          name = "${pname}-${version}";
          pname = "mbed-cli";
          version = "1.1.1";

# While we wait for the new fetchPypi to hit stable
          src = pkgs.fetchurl {
            url = "https://github.com/ARMmbed/mbed-cli/archive/${version}.zip";
#          src = ps.fetchPypi {
#            inherit pname version;
#            extension = "zip";
            sha256 = "1hxp649hfpkw33i5h4yhcm0hbd5mzj8rj0i5kd9534yrsx3glba6";
          };

          checkInputs = [ ps.pyyaml ps.pytest ];
          checkPhase = ''
            sed -i "s~- mbed~- $out/bin/mbed~" circle.yml
            sed -i "s~& mbed~\& $out/bin/mbed~" circle.yml
            sed -i "s/^.*&&.*$//" circle.yml # because hitting the network won't work anyway...
            sed -i "s/popen(\['git', 'commit'/popen(['git', 'config', 'user.email', '\"you@example.com\"']);popen(['git', 'config', 'user.name', '\"Your Name\"']);popen(['git', 'commit'/" test/util.py
            ${python.interpreter} circle_tests.py
          '';

          buildInputs = [
            git
            mercurial
          ];

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
