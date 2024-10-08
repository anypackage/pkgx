﻿# Copyright (c) Thomas Nieto - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the MIT license.

using module AnyPackage
using namespace AnyPackage.Provider

[PackageProvider('pkgx')]
class PkgxProvider : PackageProvider, IFindPackage, IGetPackage, IInstallPackage, IUninstallPackage {
    [void] FindPackage([PackageRequest] $request) {
        if ($request.Name -eq '*') {
            $request.WriteVerbose('pkgx does not support wildcards.')
            return
        }

        pkgx mash pkgx/pantry-inventory $request.Name |
            ForEach-Object {
                if ($request.IsMatch([PackageVersion]$_)) {
                    $package = [PackageInfo]::new($request.Name, $_, $request.ProviderInfo)
                    $request.WritePackage($package)
                }
            }
    }

    [void] GetPackage([PackageRequest] $request) {
        $pattern = 'exec pkgx \+(?<name>[\w\./]+)((?:[@^])(?<version>[\d\.]+))?'
        $packages = Select-String -Path ~/.local/bin/* -Pattern $pattern |
            Select-Object -ExpandProperty Matches -Unique

        $basePath = '~/.pkgx'

        foreach ($package in $packages) {
            $name = $package.Groups['name']

            if ($package.Groups['version'].Success) {
                $versionBin = $package.Groups['version'].Value
                $versionPath = Join-Path -Path $basePath -ChildPath "$name/v$versionBin"
            } else {
                $versionPath = Join-Path -Path $basePath -ChildPath "$name/v*"
                $versionBin = $null
            }

            $versionDirectory = Get-Item -LiteralPath $versionPath -ErrorAction SilentlyContinue

            if (-not $versionDirectory -and $versionBin) {
                $version = $versionBin
            } elseif (-not $versionDirectory) {
                $version = $null
            } elseif ($versionDirectory.Target) {
                $version = $versionDirectory.Target -replace 'v', ''
            } else {
                $version = $versionDirectory.Name -replace 'v', ''
            }

            if ($version -and $request.IsMatch($name, $version)) {
                $packageInfo = [PackageInfo]::new($name, $version, $request.ProviderInfo)
                $request.WritePackage($packageInfo)
            } elseif ($request.IsMatch($name)) {
                $packageInfo = [PackageInfo]::new($name, $request.ProviderInfo)
                $request.WritePackage($packageInfo)
            }
        }
    }

    [void] InstallPackage([PackageRequest] $request) {
        if ($request.Version -and $request.Version.MinVersion -ne $request.Version.MaxVersion) {
            $findPackageParams = @{
                Name     = $request.Name
                Version  = $request.Version
                Provider = $request.ProviderInfo.FullName
            }

            $version = Find-Package @findPackageParams |
                Sort-Object -Property Version -Descending |
                Select-Object -ExpandProperty Version -First 1

            $name = '{0}@{1}' -f $request.Name, $version
        } elseif ($request.Version) {
            $version = $request.Version.MinVersion
            $name = '{0}@{1}' -f $request.Name, $version
        } elseif ($request.Name.Contains('@')) {
            $name, $version = $request.Name -split '@'
        } else {
            $version = $null
            $name = $request.Name
        }

        $output = pkgx install $name 2>&1 |
            ForEach-Object {
                $request.WriteVerbose($_)
                $_
            }

        foreach ($line in $output) {
            if ($line -match '^pkgx: installed:') {
                $package = [PackageInfo]::new($request.Name, $version, $request.ProviderInfo)
                $request.WritePackage($package)
                break
            }
        }
    }

    [void] UninstallPackage([PackageRequest] $request) {
        if ((-not $request.Package -and $request.Version) -or $request.Name.Contains('@')) {
            throw 'pkgx does not support specifying version.'
        }

        $output = pkgx uninstall $request.Name 2>&1 |
            ForEach-Object {
                $request.WriteVerbose($_)
                $_
            }

        foreach ($line in $output) {
            if ($line -match '^uninstalled:') {
                $package = [PackageInfo]::new($request.Name, $request.Package.Version, $request.ProviderInfo)
                $request.WritePackage($package)
                break
            }
        }
    }

    [bool] IsSource([string] $source) {
        return $false
    }
}

[guid] $id = '95ab509b-e244-4c8b-ad5f-ecea73c68495'
[PackageProviderManager]::RegisterProvider($id, [PkgxProvider], $MyInvocation.MyCommand.ScriptBlock.Module)

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    [PackageProviderManager]::UnregisterProvider($id)
}
