{ lib
, appimageTools
, fetchurl
}:

let
  pname = "ankama-launcher";
  version = "latest";

  src = fetchurl {
    url = "https://launcher.cdn.ankama.com/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage";
    sha256 = "sha256-0JJCTEpiGABy8yetwdZpGdxR0vwLBFY9ktdDp9fNKr4=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    gtk3
    libdrm
    libglvnd
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd
    udev
    wayland
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxcb
    libxshmfence
  ];

  extraInstallCommands = ''
    desktopFile=$(find ${appimageContents} -maxdepth 1 -name "*.desktop" | head -n1)
    if [ -n "$desktopFile" ]; then
      mkdir -p $out/share/applications
      install -m 444 "$desktopFile" $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-quiet 'Exec=AppRun' 'Exec=${pname}' \
        --replace-quiet 'Exec=AppRun --no-sandbox' 'Exec=${pname}'
    fi

    if [ -d "${appimageContents}/usr/share/icons" ]; then
      mkdir -p $out/share/icons
      cp -r ${appimageContents}/usr/share/icons/. $out/share/icons/
    fi
  '';

  meta = with lib; {
    description = "Launcher officiel Ankama (Dofus, Wakfu, ...) packagé depuis l'AppImage";
    homepage = "https://www.ankama.com";
    platforms = [ "x86_64-linux" ];
  };
}
