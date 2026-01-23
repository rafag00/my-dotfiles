{pkgs, ...}: {
  home.packages = [
    (let
      # Use the same firefox package your system uses
      pkg = pkgs.firefox;
      desktopFile = "firefox.desktop";
      # CHANGE THIS: The path to your desired icon
      newIcon = "/home/rafag00/nix/home-manager/rafag00/extra/derp_fox.png";
    in
      (pkgs.runCommand "firefox-icon-fix" {} ''
        mkdir -p $out/share/applications
        substitute ${pkg}/share/applications/${desktopFile} $out/share/applications/${desktopFile} \
          --replace-fail "Icon=firefox" "Icon=${newIcon}"
      '').overrideAttrs (_: {
        meta.priority = -1; # Ensures this version of the .desktop file wins
      }))
  ];

  programs.firefox = {
    enable = true;

    languagePacks = [
      "en-US"
      "pt-PT"
    ];

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.search.defaultenginename" = "ddg";
          "browser.search.order.1" = "ddg";
          "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.cache.disk.enable" = false;
          "browser.startup.homepage" = "about:home";
          "browser.search.region" = "PT";
          "browser.uidensity" = 1;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          "browser.startup.page" = 3;
          "signon.autofillForms" = false;
        };
        search = {
          force = true;
          default = "ddg";
          order = ["ddg" "google"];
        };
        containers = {
          work = {
            name = "Work";
            color = "orange";
            icon = "briefcase";
            id = 1;
          };
        };
      };
    };
  };
}
