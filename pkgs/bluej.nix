# pkgs/bluej.nix
{ lib, stdenv, fetchurl, dpkg, buildFHSEnv, libx11, libxext, libxrender, libxtst, libxi, gtk2, glib, libGL }:

let
  pname = "bluej";
  version = "5.5.0";

  bluej-src = fetchurl {
    url = "https://github.com/k-pet-group/BlueJ-Greenfoot/releases/download/BLUEJ-RELEASE-${version}/BlueJ-linux-x64-${version}.deb";
    sha256 = "c060301af30705bd231eaf37655eb0198ce3bdcaaa228393c09622003f5a4a02";
  };

  bluej-unpacked = stdenv.mkDerivation {
    pname = "${pname}-unpacked";
    inherit version;
    src = bluej-src;
    nativeBuildInputs = [ dpkg ];
    unpackPhase = "dpkg-deb -x $src .";
    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out
    '';
  };
in
buildFHSEnv {
  name = pname;
  targetPkgs = pkgs: [
    bluej-unpacked
    libx11
    libxext
    libxrender
    libxtst
    libxi
    gtk2
    glib
    libGL
  ];
  runScript = "/usr/bin/bluej";

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cat > $out/share/applications/${pname}.desktop <<EOF
[Desktop Entry]
Name=BlueJ
Exec=${pname}
Type=Application
Categories=Development;IDE;
EOF
  '';

  meta = with lib; {
    description = "Java IDE pour débutants, packagé depuis le .deb officiel";
    homepage = "https://www.bluej.org";
    platforms = [ "x86_64-linux" ];
  };
}
