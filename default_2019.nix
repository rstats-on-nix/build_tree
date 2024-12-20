let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/refs/heads/REPLACE_DATE.tar.gz") {};
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocales nix;
};
 r_packages = builtins.attrValues {
  inherit (pkgs.rPackages)
    callr ps bit64 rstudioapi bit broom systemfonts clipr rematch2
    ggplot2 icosa sf stars devtools openssl
    haven rematch knitr munsell RColorBrewer readxl colorspace generics
    later dplyr cli fs evaluate crayon mime ragg tinytex rJava xlsxjars openxlsx
    lubridate processx data_table yaml rappdirs httr readr hms highr
    memoise RcppEigen nloptr igraph RCurl RSQLite rstan rlang
    shiny dbplyr base64enc prettyunits xml2 progress askpass sys
    tidyr curl DBI rprojroot backports blob selectr promises
    Rcpp xfun stringr tidyselect tidyverse htmltools purrr stringi
    timechange cellranger modelr zoo forcats rvest htmlwidgets scales pkgconfig
    vctrs glue tibble pillar jsonlite magrittr withr R6 fansi utf8
    viridisLite gtable labeling isoband rmarkdown digest farver
    ;
};
 wrapped_pkgs = pkgs.rWrapper.override {
  packages = [ r_packages ];
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ system_packages r_packages wrapped_pkgs ];

  } 
