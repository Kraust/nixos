{
  stdenv,
  autoPatchelfHook,
  lib,
  fetchurl,
  makeWrapper,
  unzip,
  qt5
}:

stdenv.mkDerivation rec {
  pname = "sto-cat";
  version = "none";

  src = fetchurl {
    url = "https://cat.danfai.de/sto-cat-x86_64.zip";
    sha256 = "25ac3fca9a0179f6aa4fdb5609423026844dacbb75a60ac6cb92143b49d12145";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    unzip
    qt5.full
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    unzip $src -d $out
    chmod 755 $out

    runHook postInstall

    mkdir -p $out/bin
    makeWrapper $out/sto-cat-x86_64 $out/bin/sto-cat
  '';

  meta = with lib; {
    description = "sto-cat";
    homepage = "https://cat.danfai.de/";
    license = licenses.unfree;
    maintainers = with maintainers; [ kraust ];
    platforms = [ "x86_64-linux" ];
  };
}
