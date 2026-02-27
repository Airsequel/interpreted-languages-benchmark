{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, }:
    let
      supportedSystems = [
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-darwin"
      ];
    in
    utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [
            "mbedtls-2.28.10" # Required by haxe
          ];
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bash
            bun
            coreutils
            crystal
            dart
            dash
            deno
            # dmd  # D language TODO: Currently broken on macOS
            dotnet-sdk
            elixir
            elvish
            erlang
            # factor
            fish
            fpc # Free Pascal Compiler
            # gforth
            # gfortran  # TODO: Currently broken on macOS
            ghc
            git
            # gnu-smalltalk
            # gnat15 # Ada compiler TODO: Currently broken on macOS
            gnumake
            groovy
            guile
            haxe
            hyperfine
            # j
            janet
            jq
            julia-lts
            kotlin
            ksh
            # ldc
            lua
            luajit
            luau
            microhs
            nickel
            nim
            nodejs
            nushell
            ocaml
            openjdk
            # osh
            perl
            php
            python3
            # r
            # racket  # TODO: Currently broken on macOS
            ruby
            rust-script
            rustc
            scala
            sqlite
            stack
            swift
            tcl
            tcsh
            # tinycc  # TODO: Currently broken on macOS
            typst
            uiua
            vlang
            zig
            zsh
          ];
        };
      });
}
