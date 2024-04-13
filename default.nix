{ lib, stdenv, fetchFromGitHub, makeWrapper, bash, coreutils, gnused, gnugrep, jq }:

let
  version = "1.0.6";
  tofuenv = stdenv.mkDerivation rec {
    pname = "tofuenv";
    inherit version;

    src = fetchFromGitHub {
      owner = "tofuutils";
      repo = "tofuenv";
      rev = "v${version}";
      sha256 = "1smp68x7sg282nyivchwnfl8w69ih6xv06zyhwwm61q1wk";
    };

    nativeBuildInputs = [ makeWrapper ];
    buildInputs = [ bash coreutils gnused gnugrep jq ];

    buildPhase = ''
      substituteInPlace libexec/tofuenv---version \
        --replace-warn 'version="${version}"' 'version="${version}"'
    '';

    installPhase = ''
      mkdir -p $out/{bin,libexec,lib}
      cp -r libexec/* $out/libexec/
      cp -r lib/* $out/lib/
      cp bin/tofuenv $out/bin/tofuenv
      cp CHANGELOG.md $out/CHANGELOG.md
    '';

    postFixup = ''
      wrapProgram $out/bin/tofuenv \
        --prefix PATH : ${lib.makeBinPath buildInputs} \
        --set TOFUENV_ROOT $out
    '';

    meta = with lib; {
      description = "Tofu version manager";
      homepage = "https://github.com/tofuutils/tofuenv";
      license = licenses.mit;
      maintainers = with maintainers; [ maddinek ];
    };

    passthru.tests = {
      version-test = stdenv.mkDerivation {
        name = "tofuenv-version-test";
        buildInputs = [ tofuenv ];
        phases = [ "installPhase" "testPhase" ];
        installPhase = "touch $out";
        testPhase = ''
          echo "Running tofuenv --version command:"
          ${tofuenv}/bin/tofuenv --version
          echo "Checking version output:"
          ${tofuenv}/bin/tofuenv --version | grep "${version}"
        '';
      };
    };
  };
in
tofuenv
