{ stdenv, fetchurl, jdk, makeWrapper }:

stdenv.mkDerivation { 
  pname = "rars";
  version = "1.7";

  src = fetchurl {
    url = "https://github.com/rarsm/rars/releases/download/v1.7/rars-1.7.jar";
    sha256 = "1944p0c619hnz5iqrbv7i61qcanamjlhm468zq7gav1yd3cn0871";
  };

  dontUnpack = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
          mkdir -p $out/share/java $out/bin
          cp $src $out/share/java/rars-1.7.jar
          makeWrapper ${jdk}/bin/java $out/bin/rars --add-flags "-jar $out/share/java/rars-1.7.jar"
  '';
}
