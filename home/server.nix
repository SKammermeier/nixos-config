{
  lib,
  username,
  host,
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
  home.homeDirectory = lib.mkIf (host != "orangepi5ultra") (lib.mkForce "/scratch/${username}/home");
}
