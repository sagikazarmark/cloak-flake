{
  description = "Nix Flake for Dagger Cloak";

  inputs = { flake-utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [ self.overlay ];
        };
      in rec {
        packages.cloak = pkgs.cloak;

        packages.default = pkgs.cloak;

        devShells.default = pkgs.mkShell { buildInputs = [ pkgs.cloak ]; };
      }) // {
        overlay = (final: prev: {
          cloak = prev.buildGoModule rec {
            name = "cloak";
            pname = "cloak";
            # version = "main";
            rev = "bf8ef7ed97d1463d0cc1c3d492032e3fd125be3e";

            src = prev.fetchFromGitHub {
              owner = "dagger";
              repo = "dagger";
              # rev = "v${version}";
              rev = "${rev}";
              sha256 = "sha256-iebhWAlR/m/xkBlYyejmPnFv5KBuEp0L5EwJ+tAnkKU=";
            };

            vendorSha256 =
              "sha256-bBc9H7sJSZo7brzf+QrJTarRrWP6pkOTGDGZqGurcSY=";

            subPackages = [ "cmd/cloak" ];

            nativeBuildInputs = [ prev.installShellFiles ];
            postInstall = ''
              installShellCompletion --cmd cloak \
                --bash <($out/bin/cloak completion bash) \
                --fish <($out/bin/cloak completion fish) \
                --zsh <($out/bin/cloak completion zsh)
            '';
          };
        });
      };
}
