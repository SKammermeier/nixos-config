{
  lib,
  username,
  ...
}: {
  programs = {
    nh = {
      enable = true;
      homeFlake = "/home/${username}/nixos-config";
    };

    zsh = {
      defaultKeymap = "emacs";
      initContent = lib.mkAfter ''
        source /etc/zinputrc
      '';
    };
  };
  home.homeDirectory = lib.mkForce "/scratch/${username}/home";
}
