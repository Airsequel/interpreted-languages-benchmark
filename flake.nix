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
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bash
            bun
            coreutils
            dart
            dash
            deno
            dotnet-sdk
            elixir
            elvish
            erlang
            # factor
            fish
            # gforth
            git
            # gnu-smalltalk
            gnumake
            groovy
            guile
            haxe
            hyperfine
            # j
            janet
            jq
            julia-lts
            ksh
            # ldc
            lua
            luajit
            luau
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
            # racket
            rust-script
            scala
            sqlite
            swift
            tcl
            tcsh
            typst
            uiua
            # v
            zsh
          ];
        };
      });
}
