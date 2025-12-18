{ config, lib, pkgs, ... }:

{
  services.cloudflared.package = lib.mkDefault pkgs.cloudflared-bin;

  systemd.services.cloudflared.environment = {
    CLOUDFLARED_NO_AUTOUPDATE = "true";
  };
}

