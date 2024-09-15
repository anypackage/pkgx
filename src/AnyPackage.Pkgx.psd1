@{
    RootModule = 'AnyPackage.Pkgx.psm1'
    ModuleVersion = '0.1.0'
    CompatiblePSEditions = @('Core')
    GUID = 'a59c17ca-0cf1-4efc-b1b6-41f3b21c586e'
    Author = 'Thomas Nieto'
    Copyright = '(c) 2024 Thomas Nieto. All rights reserved.'
    Description = 'pkgx provider for AnyPackage.'
    PowerShellVersion = '7.0'
    RequiredModules = @(
        @{ ModuleName = 'AnyPackage'; ModuleVersion = '0.7.0' }
    )
    FunctionsToExport = @()
    CmdletsToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        AnyPackage = @{
            Providers = 'pkgx'
        }
        PSData = @{
            Tags = @('AnyPackage', 'Provider', 'pkgx', 'Windows')
            LicenseUri = 'https://github.com/anypackage/pkgx/blob/main/LICENSE'
            ProjectUri = 'https://github.com/anypackage/pkgx'
        }
    }
    HelpInfoURI = 'https://go.anypackage.dev/help'
}
