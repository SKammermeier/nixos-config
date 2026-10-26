{ pkgs, pkgs-unstable, lib, config, username, nixpkgs-unstable, ... }:
{

  imports = [
    ./shell.nix
  ];


  options.allowUnfreePkg = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };


  config = {
    _module.args.pkgs-unstable = import nixpkgs-unstable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) config.allowUnfreePkg;
    };

    home.username = username;

    home.homeDirectory = "/home/${username}";

    home.packages = with pkgs; [
        nix-output-monitor
        nil
        marksman

        pkgs-unstable.claude-code
    ];

    allowUnfreePkg = [
       "claude-code"
    ];


    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) config.allowUnfreePkg;

    programs = {
      ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
          "tunnel-dos" = {
            HostName = "login.dos.cit.tum.de";
            User = "tunnel";
          };

          "*.dos" = {
            HostName = "%h.cit.tum.de";
            User = "simonk";
            ProxyJump = "tunnel-dos";
          };

          "op5" = {
            HostName = "orangepi5ultra.dos.cit.tum.de";
            User = "orangepi";
            ProxyJump = "tunnel-dos";
          };
        };
      };


    };


    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "25.11";
  };
}
