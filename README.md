# FTC dev environment in a flake

This provides a (command-line-based) development environment for FTC
on Nix.  (If you use Android Studio you do *not* need to use this).

How to use:

1. Install [nix](https://nixos.org/) and enable
   [flakes](https://nixos.wiki/wiki/flakes), if you haven't already.
2. Run `nix develop github:jhagborg/nix-ftc-env`.  This will start a
   new shell where appropriate versions of Java and the Android SDK
   are available.
3. Navigate to your project and run `./gradlew build`.

