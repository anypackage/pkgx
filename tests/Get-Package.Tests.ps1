#Requires -Modules AnyPackage.Pkgx

Describe Find-Package {
    BeforeAll {
        Install-Package -Name bun
    }

    AfterAll {
        Uninstall-Package -Name bun
    }

    Context 'with -Name parameter' {
        It 'should get' {
            { Get-Package -Name bun } |
            Should -Not -BeNullOrEmpty
        }
    }
}
