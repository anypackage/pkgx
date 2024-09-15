#Requires -Modules AnyPackage.Pkgx

Describe Uninstall-Package {
    BeforeEach {
        Install-Package -Name bun
    }

    Context 'with -Name parameter' {
        It 'should uninstall' {
            { Uninstall-Package -Name bun } |
            Should -Not -Throw
        }
    }
}
