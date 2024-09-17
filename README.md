# AnyPackage.Pkgx

[![gallery-image]][gallery-site]
[![build-image]][build-site]
[![cf-image]][cf-site]

[gallery-image]: https://img.shields.io/powershellgallery/dt/AnyPackage.Pkgx
[build-image]: https://img.shields.io/github/actions/workflow/status/anypackage/pkgx/ci.yml
[cf-image]: https://img.shields.io/codefactor/grade/github/anypackage/pkgx
[gallery-site]: https://www.powershellgallery.com/packages/AnyPackage.Pkgx
[build-site]: https://github.com/anypackage/pkgx/actions/workflows/ci.yml
[cf-site]: https://www.codefactor.io/repository/github/anypackage/pkgx

`AnyPackage.Pkgx` is an AnyPackage provider that facilitates installing `pkgx`
packages.

## Requirements

`pkgx` must be installed first. See [pkgx.sh](https://pkgx.sh) for installation
instructions.

## Install AnyPackage.Pkgx

```powershell
Install-PSResource AnyPackage.Pkgx
```

## Import AnyPackage.Pkgx

```powershell
Import-Module AnyPackage.Pkgx
```

## Sample usages

### Install a package

```powershell
Install-Package -Name node
```

### Uninstall a package

```powershell
Uninstall-Package -Name node
```
