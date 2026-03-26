{
  pkgs,
  lib,
  version ? "0.1.2",
}:

pkgs.stdenv.mkDerivation {
  pname = "flatrun";
  inherit version;

  src = pkgs.fetchzip {
    url = "https://github.com/YisuiDenghua/flatrun/archive/refs/tags/v${version}.tar.gz";
    sha256 = "sha256-3ByRRphS0+wgvzI/ETnC5I9TmqgPxWVpIpFMYkBixYE=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 flatrun.sh $out/bin/flatrun
    # link to "fr"
    ln -s $out/bin/flatrun $out/bin/fr

    runHook postInstall
  '';

  # run time wrap
  postFixup = ''
    wrapProgram $out/bin/flatrun \
      --prefix PATH : ${
        lib.makeBinPath [
          pkgs.flatpak
          pkgs.gawk
          pkgs.gnused
          pkgs.coreutils
        ]
      }
  '';

  meta = with lib; {
    description = "A simple wrapper to run Flatpak apps by matching name or ID";
    homepage = "https://github.com/YisuiDenghua/flatrun";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with lib.maintainers; [ yisuidenghua ];
    mainProgram = "flatrun";
  };
}
