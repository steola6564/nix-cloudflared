# nix-cloudflared

A minimal Nix flake providing:

- a **latest cloudflared prebuilt binary**
- a **Nixpkgs overlay**
- a **thin NixOS module** that safely overrides the package

This repository exists because the cloudflared version in nixpkgs
often lags behind upstream releases.

## Why not nixpkgs?

The cloudflared package in nixpkgs often lags behind upstream releases.
This flake exists to provide a minimal, up-to-date alternative without
reimplementing the existing NixOS module.

---

## Features

- Tracks official Cloudflare releases
- Uses upstream prebuilt binaries
- Does **not** reimplement `services.cloudflared`
- Safe to layer on top of existing NixOS setups
- Suitable for servers, homelabs, and personal infra

---

## Supported platforms

| Platform        | Status |
|-----------------|--------|
| x86_64-linux   | ✅ supported |
| aarch64-linux  | ⚠️ hash required |

---

## Usage

### As a flake input

```nix
inputs.nix-cloudflared.url = "github:steola6564/nix-cloudflared";
```

### Enable overlay

```nix
{
  nixpkgs.overlays = [
    inputs.nix-cloudflared.overlays.default
  ];
}
```

### Use NixOS module (optional)

```nix
{
  imports = [
    inputs.nix-cloudflared.nixosModules.cloudflared
  ];
}
```

This will:
- set `services.cloudflared.package` to `cloudflared-bin`
- Disable cloudflared auto-updates

---

## Verification

cloudflared is marked as an unfree redistributable package.
You need to explicitly allow unfree packages when building.

```nix
nix build .#cloudflared-bin
./result/bin/cloudflared --version
```

---

## License

This repository contains only Nix expressions.

The cloudflared binary is downloaded from official Cloudflare releases and is
licensed under the Apache License 2.0.

This repository is not affiliated with Cloudflare.
