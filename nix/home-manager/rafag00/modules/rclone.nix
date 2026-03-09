# Mounts all the rclone configurations to the home/Name with systemd services
{
  config,
  pkgs,
  ...
}: {
  home = {
    shellAliases = {
      "reload-rclone" = "systemctl --user restart rCloneMounts.service";
      "status-rclone" = "systemctl --user status rCloneMounts.service";
      "stop-rclone" = "systemctl --user stop rCloneMounts.service";
    };
  };

  systemd.user.services.rCloneMounts = {
    Unit = {
      Description = "Mount all rClone configurations";
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };
    Service = let
      home = config.home.homeDirectory;
    in {
      # Type = "simple";
      Type = "forking";
      Restart = "on-failure";
      # Restart=always;
      RestartSec = 10;

      ExecStartPre = "${pkgs.writeShellScript "rClonePre" ''
        remotes=$(${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf listremotes)
        for remote in $remotes;
        do
          name=$(echo "$remote" | sed "s/://g")
          dir="${home}/$name"

          # Unmount if stale
          if mountpoint -q "$dir"; then
              fusermount -uz "$dir" || true
          fi

          mkdir -p "$dir"
        done
      ''}";

      ExecStart = "${pkgs.writeShellScript "rCloneStart" ''
        remotes=$(${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf listremotes)
        for remote in $remotes;
        do
        name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
        ${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount "$remote" "$name" &
        done
      ''}";

      ExecStop = "${pkgs.writeShellScript "rCloneStop" ''
        remotes=$(${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf listremotes)
        for remote in $remotes;
        do
        name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
        /usr/bin/env fusermount -u ${home}/"$name"
        done
      ''}";
    };
    Install.WantedBy = ["default.target"];
  };
}
