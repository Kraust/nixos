{ 
  lib, 
  stdenv, 
  fetchFromGitHub, 
  meson, 
  ninja, 
  vala, 
  intltool, 
  glib, 
  pkg-config, 
  libgee, 
  gtk3, 
  pantheon, 
  appstream, 
  json-glib, 
  libhandy,
  budgie,
  libpeas,
  cmake,
  bamf,
}:

stdenv.mkDerivation rec {
  pname = "budgie-extras";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner  = "UbuntuBudgie";
    repo   = pname;
    rev    = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-xzvEFKBKKxJ6LGorcXk6sMXG1lvdSu+ZHyn6X5UkFoo=";
  };

  nativeBuildInputs = [
    meson
    ninja
    vala
    intltool
    glib # glib-compile-resources
    pkg-config
    appstream
    json-glib
    cmake
  ];

  buildInputs = [
    bamf
    gtk3
    libgee
    libhandy
    libpeas
    pantheon.granite
    pantheon.elementary-dock
    budgie.budgie-desktop
  ];

  doCheck = true;

  meta = with lib; {
    description = "Additional Budgie Desktop enhancements for user experience";
    homepage = "https://github.com/UbuntuBudgie/budgie-extras";
    license     = licenses.gpl3;
    maintainers = with maintainers; [ kraust ];
    platforms = platforms.unix;
  };
}
