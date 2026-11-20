{ lib
, buildDotnetModule
, dotnetCorePackages
, fastfetch
, makeWrapper
}:

buildDotnetModule rec {
  pname = "slowfetch";
  version = "0-unstable";

  src = ./.;

  projectFile = "SlowFetch/SlowFetch.csproj";
  nugetDeps = ./deps.nix;

  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.runtime_10_0;

  executables = [ "slowfetch" ];

  nativeBuildInputs = [ makeWrapper ];

  postFixup = ''
    wrapProgram $out/bin/slowfetch \
      --prefix PATH : ${lib.makeBinPath [ fastfetch ]}
  '';

  meta = with lib; {
    description = "A very slow fastfetch delivery service";
    homepage = "https://github.com/VeryUsefulSoftware/slowfetch";
    license = licenses.mit;
    mainProgram = "slowfetch";
    platforms = platforms.all;
  };
}
