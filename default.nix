{ gcc-arm-embedded
, gnumake
, cmake
, stdenv
, nrf5-sdk
, python39
, nodePackages
, mcuboot-imgtool
}:

stdenv.mkDerivation {
  pname = "infinitime";
  version = "0.0.0";

  src = ./.;

  nativeBuildInputs = [ cmake gnumake gcc-arm-embedded ];
  buildInputs = [ nodePackages.lv_font_conv python39 mcuboot-imgtool ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DARM_NONE_EABI_TOOLCHAIN_PATH=${gcc-arm-embedded}"
    "-DNRF5_SDK_PATH=${nrf5-sdk}/share/nRF5_SDK"
  ];

  installPhase = ''cp -r . $out'';
}

