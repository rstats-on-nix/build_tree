let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/refs/heads/REPLACE_DATE.tar.gz") {};
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocalesUtf8 nix;
};
 r_packages = builtins.attrValues {
  inherit (pkgs.rPackages)
    tidyverse;
};
 wrapped_pkgs = pkgs.rWrapper.override {
  packages = [ r_packages ];
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ system_packages r_packages wrapped_pkgs ];

  }
