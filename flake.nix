{
  description = "Development environment for FTC";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.simpleFlake {
    inherit self nixpkgs;
    name = "ftc-env";

    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };

    shell = { pkgs }:
      let
        # These work as of 2024-09-14 (FTC upstream commit 442c867)
        jdkVersion = "17";
        ndkVersion = "21.3.6528147";
        buildToolVersion = "30.0.3";
        buildToolAAPT2Version = "34.0.0";
        platformVersion = "29";

        androidPkgs = pkgs.androidenv.composeAndroidPackages {
          includeNDK = true;
          ndkVersions = [ ndkVersion ];
          buildToolsVersions = [ buildToolVersion buildToolAAPT2Version ];
          platformVersions = [ platformVersion ];
        };
      in pkgs.mkShell rec {
        nativeBuildInputs = [
          pkgs."jdk${jdkVersion}"
          androidPkgs.androidsdk
        ];

        ANDROID_HOME = "${androidPkgs.androidsdk}/libexec/android-sdk";
        GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=" +
                      "${ANDROID_HOME}/build-tools/${buildToolAAPT2Version}/aapt2";
      };
  };
}
