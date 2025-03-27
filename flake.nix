{
  description = "etcd-cpp-apiv3 environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs, }:
    let
      project = "etcd-cpp-apiv3";

      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });

      # cpprest = pkgs: pkgs.callPackage ./cpprestsdk { };
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell.override
          {
            # Override stdenv in order to change compiler:
            stdenv = pkgs.clangStdenv;
          }
          {
            packages = with pkgs; [
              # env
              llvmPackages_latest.clang
              llvmPackages_latest.libllvm
              llvmPackages_latest.libcxx
              llvmPackages_latest.lldb
              llvmPackages_latest.libstdcxxClang

              clang-tools

              cmake
              ninja

              ### 3td lib
              protobuf
              grpc
              openssl
              (cpprest pkgs)

              ## dependence
            ];
              

            shellHook = ''
            '';
          };
      });
    };
}

