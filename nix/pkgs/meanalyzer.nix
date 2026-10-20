{
  lib,
  fetchFromGitHub,
  buildPythonApplication,
  python,
  makeWrapper,

  colorama,
  crccheck,
  pltable,
}:

buildPythonApplication rec {
  pname = "meanalyzer";
  version = "1.312.0-r378";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "platomav";
    repo = "MEAnalyzer";
    rev = "v${version}";
    hash = "sha256-W725RXsYHZ+j1zPajwTnex4nnZU/XWe+e45NrIgHHlQ=";
  };

  dependencies = [
    colorama
    crccheck
    pltable
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/meanalyzer
    cp -r * $out/share/meanalyzer/

    mkdir -p $out/bin

    makeWrapper ${lib.getExe python} $out/bin/meanalyzer \
      --prefix PYTHONPATH : "$PYTHONPATH" \
      --add-flags "$out/share/meanalyzer/MEA.py" 

    runHook postInstall
  '';
}
