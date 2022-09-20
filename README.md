# Nix flake for [cloak](https://github.com/dagger/dagger/tree/cloak)

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/sagikazarmark/cloak-flake/CI?style=flat-square)
[![built with nix](https://img.shields.io/badge/builtwith-nix-7d81f7?style=flat-square)](https://builtwithnix.org)


## Usage

In the shell:

```shell
$ nix shell github:sagikazarmark/cloak-flake
$ which cloak
/nix/store/a4gbk52nf9g3l848yawfydmpzn8vf1dm-cloak/bin/cloak
```

In your own `flake.nix`:

```nix
  # define an input
  cloak-flake.url = "github:sagikazarmark/cloak-flake";

  # Option 1: as an overlay
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      cloak-flake.overlay
    ];
  };

  # Option 2: directly
  devShells.default = pkgs.mkShell { buildInputs = with pkgs; [ cloak-flake.defaultPackage."${system}" ]; };
```


## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
