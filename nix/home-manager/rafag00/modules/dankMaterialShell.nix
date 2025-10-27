{pkgs, ...}:
{   
    # BEst way for my config is to compile form source as I'm not using niri flake
    programs.quickshell.enable = true;
    programs.dankMaterialShell.enable = true;

    home.packages = with pkgs; [
      matugen
      jq
      wl-clipboard
      cliphist
      brightnessctl
      gammastep
      kdePackages.qtmultimedia
    ];

    # Environment
    home.file.".config/environment.d/20-qt-qml.conf".text = ''
      QML_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
      QML2_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
      QT_PLUGIN_PATH=${pkgs.kdePackages.qtimageformats}/lib/qt-6/plugins:${pkgs.kdePackages.qtsvg}/lib/qt-6/plugins:${pkgs.kdePackages.qtmultimedia}/lib/qt-6/plugins:${pkgs.kdePackages.qt5compat}/lib/qt-6/plugins
    '';


}