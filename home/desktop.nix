{ pkgs, ... } : {
  allowUnfreePkg =
    [
      "google-chrome"
      "clion"
      "pycharm"
      "rust-rover"
    ];

  home.packages = with pkgs; [
      jetbrains.clion
      jetbrains.pycharm
      jetbrains.rust-rover

      eduvpn-client

      kdePackages.kcalc # Calculator

      onlyoffice-desktopeditors
  ];

  programs.google-chrome = {
      enable = true;
      plasmaSupport = true;
  };


}
