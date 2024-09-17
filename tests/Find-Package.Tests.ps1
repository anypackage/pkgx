#Requires -Modules AnyPackage.Pkgx

Describe Find-Package {
    Context 'with -Name parameter' {
        It 'should find' {
            { Find-Package -Name bun } |
            Should -Not -BeNullOrEmpty
        }
    }
}
