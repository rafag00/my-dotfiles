{
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
          "browser.cache.disk.enable" = false; # Be kind to hard drive

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
