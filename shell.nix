with import <nixpkgs> {}; {
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
        ps.beautifulsoup4
        (ps.buildPythonPackage rec {
          name = "${pname}-${version}";
          pname = "fuzzywuzzy";
          version = "0.14.0";

          src = ps.fetchPypi {
            inherit pname version;
            sha256 = "1fd574m1rlzlpayacgyms0ivvbidszrxfawzw6am2sjma6p0h8wg";
          };

          checkInputs = [ ps.hypothesis ps.pycodestyle ps.pytest ];
          checkPhase = ''
            py.test
          '';

          meta = {
            homepage = "https://github.com/seatgeek/fuzzywuzzy";
            description = "Fuzzy String Matching in Python";
            license = licenses.gpl2;
          };
        })
        (ps.buildPythonPackage rec {
          name = "${pname}-${version}";
          pname = "intelhex";
          version = "2.1";

          src = ps.fetchPypi {
            inherit pname version;
            sha256 = "0k5l1mn3gv1vb0jd24ygxksx8xqr57y1ivgyj37jsrwpzrp167kw";
          };

          # tests do not pass: https://github.com/bialix/intelhex/issues/14
          doCheck = false;

          meta = {
            homepage = "https://github.com/bialix/intelhex";
            description = "Python IntelHex library";
            license = licenses.bsd3;
          };
        })
        (ps.buildPythonPackage rec {
          name = "${pname}-${version}";
          pname = "mbed-cli";
          version = "1.1.1";

          src = ps.fetchPypi {
            inherit pname version;
            extension = "zip";
            sha256 = "1mrnrl94fqw8i5klv637ac9g0ypvrfdikgkcwsfy4j7h9dffhpym";
          };

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
