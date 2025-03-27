{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  boost,
  cpprestsdk,
  grpc,
  protobuf,
  openssl
}@ args:

stdenv.mkDerivation rec{
  pname = "etcd-cpp-apiv3";
  version = "unstable";

  src = fetchFromGitHub ({
    owner = "cyclesw";
    repo = "etcd-cpp-apiv3";
    rev = "fixSubmoduleHeadless";
    # sha256 = "sha256-zKam91x6wbG0vOxFXGQI/RKFf+fXGbn166YTjZUJ6yY=";
  });

  buildInputs = [];
  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [ openssl boost cpprestsdk grpc protobuf];

  # cmakeFlags = [
  #   "-DWERROR=OFF"
  #   "-DCPPREST_EXCLUDE_WEBSOCKETS=ON"
  #   "-DCPPREST_EXCLUDE_COMPRESSION=ON"
  # ];
}