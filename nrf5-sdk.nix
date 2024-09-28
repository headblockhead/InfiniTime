{ lib
, stdenv
, fetchzip
}:

stdenv.mkDerivation rec {
  pname = "nrf5-sdk";
  version = "15.3.0";

  urlHash = "59ac345";

  src = fetchzip {
    url = "https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/nRF5_SDK_${version}_${urlHash}.zip";
    hash = "sha256-pfmhbpgVv5x2ju489XcivguwpnofHbgVA7bFUJRTj08=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/nRF5_SDK
    mv * $out/share/nRF5_SDK
    rm $out/share/nRF5_SDK/*.msi

    runHook postInstall
  '';

  meta = with lib; {
    description = "Nordic Semiconductor nRF5 Software Development Kit";
    homepage = "https://www.nordicsemi.com/Products/Development-software/nRF5-SDK";
    license = licenses.unfree;
    platforms = platforms.all;
    maintainers = with maintainers; [ stargate01 ];
  };
}
