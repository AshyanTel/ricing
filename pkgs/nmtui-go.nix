{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "nmtui-go";
  version = "0.2.7";

  src = fetchFromGitHub {
    owner = "doeixd";
    repo = "nmtui-go";
    rev = "v${version}";
    hash = "sha256-2X1npAiE4OvlLQgdDKLCAWdjG3yZcVst7Q+ZyI2IYys=";
  };

  vendorHash = "sha256-FYrLLZHd7C98LzmIUuEpJxLEqT2j/7GWHTcjNRRV4xY=";
  
  postInstall = ''
    mv $out/bin/cmd $out/bin/nmtui-go
  '';

  meta = {
    description = "A TUI for managing NetworkManager Wi-Fi connections";
    homepage = "https://github.com/doeixd/nmtui-go";
    license = lib.licenses.mit;
    mainProgram = "nmtui-go";
  };
}
