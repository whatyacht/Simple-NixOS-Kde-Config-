{ inputs, ... }:

{
  flake.modules.generic.home-zen = { pkgs, lib, ... }: {
    home.packages = [
      inputs.zen-desktop.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home.activation.setZenProxyPort =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        config="$HOME/.config/zen/config.json"

        if [ -f "$config" ]; then
          ${pkgs.jq}/bin/jq '.proxy.port = 28733' "$config" > "$config.tmp" \
            && mv "$config.tmp" "$config"
        fi
      '';
  };
}
