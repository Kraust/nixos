{
  lib,
  stdenv,
  fetchFromGitHub,
  unstableGitUpdater,
  pkgs
}:

stdenv.mkDerivation {
  pname = "cpu-speed";
  version = "1.0.0-unstable-2024-08-07";

  src = fetchFromGitHub {
    owner = "svlv";
    repo = "cpu-speed";
    rev = "1394bfa052c8fb98891b355c8befa95eb32ca1c1";
    hash = "sha256-/iBlxXfgt+pBgnWYv+1J033t/Vv4rD9aLxjnQo3HPzA=";
  };

  buildInputs = [
    pkgs.lm_sensors
    pkgs.ncurses5
  ];

  makeFlags = [ "PREFIX=${placeholder "out"}" ];

  passthru.updateScript = unstableGitUpdater { };

  meta = with lib; {
    description = "CPU clock speed monitor for Linux";
    homepage = "https://github.com/svlv/cpu-speed";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ kraust ];
    mainProgram = "cpu-speed";
  };
}
