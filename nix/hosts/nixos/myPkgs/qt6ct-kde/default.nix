{
  lib,
  stdenv,
  fetchFromGitLab,
  fetchpatch,
  cmake,
  qt6,
  kdePackages,
}:
stdenv.mkDerivation rec {
  pname = "qt6ct-kde";
  version = "0.11";

  # Upstream source from the trialuser opencode repo
  src = fetchFromGitLab {
    domain = "www.opencode.net";
    owner = "trialuser";
    repo = "qt6ct";
    rev = version;
    # Updated with the 'got' hash from your error message
    hash = "sha256-aQmqLpM0vogMsYaDS9OeKVI3N53uY4NBC4FF10hK8Uw=";
  };

  nativeBuildInputs = [
    cmake
    qt6.qttools
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtsvg
    kdePackages.qqc2-desktop-style
  ];

  patches = [
    # Apply the "shenanigans" patch from the AUR repository
    (fetchpatch {
      name = "qt6ct-shenanigans.patch";
      url = "https://aur.archlinux.org/cgit/aur.git/plain/qt6ct-shenanigans.patch?h=qt6ct-kde";
      # Updated with the 'got' hash from your previous error message
      hash = "sha256-odCe+7fPnIQtOrPqYAS15rm+wsedy6zjwnieUZSfxp0=";
    })
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
    "-DPLUGINDIR=${placeholder "out"}/${qt6.qtbase.qtPluginPrefix}"
  ];

  meta = with lib; {
    description = "Qt6 Configuration Utility, patched for KDE/KColorScheme support";
    homepage = "https://www.opencode.net/trialuser/qt6ct";
    license = licenses.bsd2;
    platforms = platforms.linux;
  };
}
