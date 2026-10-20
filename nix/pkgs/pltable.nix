{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
}:

buildPythonPackage rec {
  pname = "PLTable";
  version = "1.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-3I63y5chpwkNx6WXb77H0+9rgqYfhsO5hwBXGj8QQBo=";
  };

  build-system = [ setuptools ];

  pythonImportsCheck = [ "pltable" ];
}
