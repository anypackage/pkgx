# AnyPackage.Pkgx

`AnyPackage.Pkgx` is an AnyPackage provider that facilitates installing `pkgx` packages.

## Requirements

`pkgx` must be installed first. See [pkgx.sh](https://pkgx.sh) for installation
instructions.

## Install AnyPackage.Pkgx

```PowerShell
Install-PSResource AnyPackage.Pkgx
```

## Import AnyPackage.Pkgx

```PowerShell
Import-Module AnyPackage.Pkgx
```

## Sample usages

### Install a package

```PowerShell
Install-Package -Name node
```

### Uninstall a package

```PowerShell
Uninstall-Package -Name node
```
