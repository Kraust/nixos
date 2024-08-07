{ lib
, stdenv
, fetchFromGitHub
, kernel
}:

let
  version = "0.1.5-unstable-2024-08-06-4";

  ## Upstream has not been merging PRs.
  ## Nixpkgs maintainers are providing a
  ## repo with PRs merged until upstream is
  ## updated.
  src = fetchFromGitHub {
    owner = "Kraust";
    repo = "ryzen_smu";
    rev = "57e15b380a5b4fef3f9b8729f870dd3411c4b801";
    hash = "sha256-vs27t2SZ/h3mLb52pLHcXihO4jOIAXSBiamPe/++Moc=";
  };

  monitor-cpu = stdenv.mkDerivation {
    pname = "monitor-cpu";
    inherit version src;

    makeFlags = [
      "-C userspace"
    ];

    installPhase = ''
      runHook preInstall

      install userspace/monitor_cpu -Dm755 -t $out/bin

      runHook postInstall
    '';
  };

in
stdenv.mkDerivation {
  pname = "ryzen-smu-${kernel.version}";
  inherit version src;

  hardeningDisable = [ "pic" ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "TARGET=${kernel.modDirVersion}"
    "KERNEL_BUILD=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    runHook preInstall

    install ryzen_smu.ko -Dm444 -t $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/ryzen_smu
    install ${monitor-cpu}/bin/monitor_cpu -Dm755 -t $out/bin

    runHook postInstall
  '';

  meta = with lib; {
    description = "Linux kernel driver that exposes access to the SMU (System Management Unit) for certain AMD Ryzen Processors";
    homepage = "https://gitlab.com/leogx9r/ryzen_smu";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ Cryolitia phdyellow ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "monitor_cpu";
  };
}
