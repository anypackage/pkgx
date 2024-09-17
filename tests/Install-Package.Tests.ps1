#Requires -Modules AnyPackage.Pkgx

Describe Install-Package {
    AfterEach {
        Uninstall-Package -Name bun
    }

    Context 'with -Name parameter' {
        It 'should install' {
            { Install-Package -Name bun } |
            Should -Not -Throw
        }
    }
}
