{ lib
, stdenv
, fetchurl
, p7zip
, asar
, makeWrapper
, autoPatchelfHook
, electron_37-bin

, pkgver ? "4.24.0"
, bettersqlite3ver ? "12.4.0"
, bufferutilver ? "4.0.9"
, electronModuleVer ? "136"

, icon ? ./notion.png
, desktopFile ? ./notion.desktop
, wrapper ? ./notion-app
}:

stdenv.mkDerivation rec {
  pname = "notion-app-electron";
  version = pkgver;

  src = fetchurl {
    url = "https://desktop-release.notion-static.com/Notion%20Setup%20${pkgver}.exe";
    sha256 = "f878e8e4d7c1155cb98279a0ba81b16aa5f589475c55ce334fc4d1a3666ee18f";
  };

  betterSqlite = fetchurl {
    url = "https://github.com/WiseLibs/better-sqlite3/releases/download/v${bettersqlite3ver}/better-sqlite3-v${bettersqlite3ver}-electron-v${electronModuleVer}-linux-x64.tar.gz";
    sha256 = "97837974a8990e4f4df1f3921879ebefa18e691041392120255c3a99e3fef030";
  };

  bufferUtil = fetchurl {
    url = "https://github.com/websockets/bufferutil/releases/download/v${bufferutilver}/v${bufferutilver}-linux-x64.tar";
    sha256 = "2139aae79c5a4fd4d07467bd9b7872ea109483aa43b3dfd6c8d3725ccba009be";
  };

  nativeBuildInputs = [ 
    p7zip 
    asar 
    makeWrapper 
    autoPatchelfHook
  ];

  buildInputs = [ 
    electron_37-bin 
    stdenv.cc.cc.lib
    # zlib           # Uncomment if you get zlib errors later
  ];

  unpackPhase = ''
    7z x $src "\$PLUGINSDIR/app-64.7z" -y -bse0 -bso0 || true
    7z x "\$PLUGINSDIR/app-64.7z" "resources/app.asar" "resources/app.asar.unpacked" -y -bse0 -bso0 || true
  '';

  patchPhase = ''
    # extracting resources from app.asar
    asar e resources/app.asar asar_patched

    # replacing better_sqlite3 release in the patched resources
    tar xf ${betterSqlite}
    install -vDm644 build/Release/better_sqlite3.node asar_patched/node_modules/better-sqlite3/build/Release/better_sqlite3.node

    # replacing bufferutil release in the patched resources
    tar xf ${bufferUtil}
    install -vDm644 linux-x64/bufferutil.node asar_patched/node_modules/bufferutil/build/Release/bufferutil.node

    # adding tray icon to the unpacked resources
    install -vDm644 ${icon} asar_patched/.webpack/main/trayIcon.png

    # fixing tray icon and right click menu
    sed -i 's|this.tray.on("click",(()=>{this.onClick()}))|this.tray.setContextMenu(this.trayMenu),this.tray.on("click",(()=>{this.onClick()}))|g' asar_patched/.webpack/main/index.js
    sed -i 's|getIcon(){[^}]*}|getIcon(){return require("path").resolve(__dirname, "trayIcon.png");}|g' asar_patched/.webpack/main/index.js
    
    # fake the useragent as windows to fix the spellchecker languages selector and other issues
    sed -i 's|e.setUserAgent(`''${e.getUserAgent()} WantsServiceWorker`),|e.setUserAgent(`''${e.getUserAgent().replace("Linux", "Windows")} WantsServiceWorker`),|g' asar_patched/.webpack/main/index.js
    
    # fully disabling auto updates
    sed -i 's|if("darwin"===process.platform){const e=l.systemPreferences?.getUserDefault(C,"boolean"),t=M.Store.getState().app.preferences?.isAutoUpdaterDisabled,r=M.Store.getState().app.preferences?.isAutoUpdaterOSSupportBypass,n=(0,y.isOsUnsupportedForAutoUpdates)();return Boolean(e\|\|t\|\|!r\&\&n)}return!1|return!0|g' asar_patched/.webpack/main/index.js
    
    # avoid running duplicated instances, fixes url opening
    sed -i 's|handleOpenUrl);else if("win32"===process.platform)|handleOpenUrl);else if("linux"===process.platform)|g' asar_patched/.webpack/main/index.js
    sed -i 's|async function(){(0,E.setupCrashReporter)(),|o.app.requestSingleInstanceLock() ? async function(){(0,E.setupCrashReporter)(),|g' asar_patched/.webpack/main/index.js
    sed -i 's|setupCleanup)()}()}()|setupCleanup)()}()}() : o.app.quit();|g' asar_patched/.webpack/main/index.js
    
    # use the windows version of the tray menu
    sed -i 's|r="win32"===process.platform?function(e,t)|r="linux"===process.platform?function(e,t)|g' asar_patched/.webpack/main/index.js

    # Copy package.json before repacking
    cp asar_patched/package.json ./package.json

    # repacking asar with all the patches
    asar p asar_patched app.asar --unpack "*.node"
  '';

  dontBuild = true;

  installPhase = ''

    outLib="$out/lib/notion-app"
    mkdir -p "$outLib"
    mkdir -p "$out/bin"
    mkdir -p "$out/share/applications"
    mkdir -p "$out/share/icons/hicolor/256x256/apps"

    cp app.asar "$outLib/"
    cp -r app.asar.unpacked "$outLib/"

    # Copy package.json to fix package.json missing error
    cp package.json "$outLib/"

    install -Dm755 ${wrapper} "$out/bin/notion-app"
    install -Dm644 ${desktopFile} "$out/share/applications/notion.desktop"
    install -Dm644 ${icon} "$out/share/icons/hicolor/256x256/apps/notion.png"
    
    # This fixes the wrapper:
    #  - Set the correct electron path
    #  - Set the correct notion lib path
    #  - Fixes the database error in NixOS by adding the system lib path to LD_LIBRARY_PATH
    substituteInPlace "$out/bin/notion-app" \
      --replace "electron37" "${electron_37-bin}/bin/electron" \
      --replace "/usr/lib/notion-app" "$outLib" \
      --replace "# Launch" "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${lib.makeLibraryPath [ stdenv.cc.cc.lib ]}
    cd \"$outLib\"
    "
  '';

  meta = with lib; {
    description = "Your connected workspace for wiki, docs & projects. Follows the notion-app-electron from the aur.";
    homepage = "https://www.notion.so/desktop";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}