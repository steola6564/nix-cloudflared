{ stdenvNoCC
, fetchurl
, lib
, system
}:

let
  version = "2025.8.1";

  urls = {
    x86_64-linux  = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-linux-amd64";
    aarch64-linux = "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-linux-arm64";
  };

  hashes = {
    x86_64-linux  = "sha256-pmNTAEGX7kwfy2hUkgOCSIK7piN4rU0A0jS9uCUfERQ=";
    # aarch64-linux = "...";
  };
in
stdenvNoCC.mkDerivation {
  pname = "cloudflared-bin";
  inherit version;

  src = fetchurl {
    url = urls.${system}
      or (throw "cloudflared-bin: unsupported system ${system}");
    sha256 = hashes.${system}
      or (throw "cloudflared-bin: missing hash for ${system}");
  };

  dontUnpack = true;

  installPhase = ''
    install -Dm755 "$src" "$out/bin/cloudflared"
  '';

  meta = with lib; {
    description = "Cloudflare Tunnel daemon (prebuilt binary)";
    homepage = "https://developers.cloudflare.com/cloudflare-one/";
    license = licenses.unfreeRedistributable;
    platforms = builtins.attrNames urls;
    mainProgram = "cloudflared";
  };
}

