{ lib
, fetchPypi
, python3Packages
,
}:

python3Packages.buildPythonApplication rec {
  pname = "OSCR-UI";
  version = "2024.6b91";
  format = "pyproject";

  src = fetchPypi {
    pname = "oscr_ui";
    inherit version;
    sha256 = "x+UhnPOKI81nHtuMLJmR7oUN/4Mn2+0uJZDByMK34jg=";
  };

  propagatedBuildInputs = [
    python3Packages.hatchling
    python3Packages.numpy
    python3Packages.pyqtgraph
    python3Packages.pyside6
  ];

  meta = with lib; {
    description = "Open Source Combatlog Reader for Star Trek Online";
    homepage = "https://oscr.stobuilds.com/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ kraust ];
    platforms = platforms.linux;
  };
}
