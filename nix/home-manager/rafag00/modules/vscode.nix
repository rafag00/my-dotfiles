{
  home.file.".vscode/argv.json" = {
    force = true;
    text = ''
      // This configuration file allows you to pass permanent command line arguments to VS Code.
      // Only a subset of arguments is currently supported to reduce the likelihood of breaking
      // the installation.
      //
      // PLEASE DO NOT CHANGE WITHOUT UNDERSTANDING THE IMPACT
      //
      // NOTE: Changing this file requires a restart of VS Code.
      {
        // Use software rendering instead of hardware accelerated rendering.
        // This can help in cases where you see rendering issues in VS Code.
        // "disable-hardware-acceleration": true,

        // Allows to disable crash reporting.
        // Should restart the app if the value is changed.
        "enable-crash-reporter": false,

        // Unique id used for correlating crash reports sent from this instance.
        // Do not edit this value.
        "crash-reporter-id": "eb21d9de-8e34-4375-a252-258ddadcdc00",
        "password-store": "gnome"
      }
    '';
  };
}
