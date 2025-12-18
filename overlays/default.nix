final: prev: {
  cloudflared-bin =
    final.callPackage ../pkgs/cloudflared-bin {
      system = final.stdenv.hostPlatform.system;
    };
}

