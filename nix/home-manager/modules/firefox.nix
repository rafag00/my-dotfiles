{
    programs.firefox = {
        enable = true;

        #DisablePocket = true;
        
        #Need to add derpfox icon

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
            };
            search = {
                force = true;
                default = "ddg";
                order = [ "ddg" "google" ];
                };
            };
        };

        policies = {
            AutofillCreditCardEnabled = false;
            DisplayMenuBar = "default-off";
            OfferToSaveLoginsDefault = false;
        };
    };
}