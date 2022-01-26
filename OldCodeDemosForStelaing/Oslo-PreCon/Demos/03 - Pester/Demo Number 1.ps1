## Pester Demo
## Just a failsafe ;-)
Return "This is a demo Beardy!"

# Install-Module Pester -Scope CurrentUser -SkipPublisherCheck

# I hate this advice - you really need to take ownership of the pester folder in Programme files Windows PowerShell Modules and delete it rather than skipping a security check but anyway

# Update-Module Pester -Force

Get-Module Pester -ListAvailable

Get-Module Pester

## Does it exist ?

Describe "Do things Exist" {
    Context "Servers" {
        It "The Server returns a ping - This will fail - Wrong Server Name" {
            (Test-Connection Exeter -Count 1 -Quiet -ErrorAction SilentlyContinue ) | Should -Be $true
        }
        It "The Server $SQL0 returns a ping" {
            (Test-Connection $SQL0 -Count 1 -Quiet -ErrorAction SilentlyContinue ) | Should -Be $true
        }
        It "Operating System Version" {
            (Get-CimInstance -ClassName Win32_OperatingSystem).Version | Should -Be '10.0.16299'
        }
    }
    Context "Shares and Files" {
        It "The Backup Share $Share exists and is accessible" {
            Test-Path $Share | Should -Be $true
        }
        It "Should have the txt file" {
            Test-Path C:\Octopus\Logs\OctopusServer.0.txt | should -Be $true
        }
        It "folder should have only 16 files" {
            (Get-ChildItem C:\Octopus\Logs).Count | Should -Be 16
        }
        It "Exe should be of this version" {
            (Get-ChildItem "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\SQLPS.exe").VersionInfo.FileVersion | Should -Be '14.0.1000.169 ((SQLServer).170822-2340)'
        }
        It "File should have been created on this date"{
            (Get-ChildItem 'C:\Program Files\WindowsPowerShell\Modules\dbatools\0.9.25\dbatools.psm1').CreationTime | Should -Be '08/10/2017 11:24:10'
        }
        It "File should not have been modified since this date"{
            (Get-ChildItem 'C:\Program Files\WindowsPowerShell\Modules\dbatools\0.9.25\functions\Remove-DbaDatabaseSafely.ps1').LastWriteTime| Should -BeLessThan '09/08/2017 04:37:17'
        }
    }
    Context "Networks" {
        It "Should have 6 Network Adapters" {
            (Get-NetAdapter).COunt | Should -Be 10
        }
        It "Should have correct DNS Servers" {
            (Get-DnsClientServerAddress -InterfaceAlias 'vEthernet (Beard Internal)').Serveraddresses | Should -Be @('10.0.0.1')
        }
        
        (Get-DnsClientServerAddress -InterfaceAlias 'vEthernet (Beard Internal)').Serveraddresses.ForEach{
            It "DNS Server $($_) should respond to ping" {
                (Test-Connection $_ -Count 1 -Quiet -ErrorAction SilentlyContinue ) | Should -Be $true
            }
        }
        It "Should have the Correct Gateway"{
            (Get-NetIPConfiguration -InterfaceAlias 'Wifi').Ipv4DefaultGateway.NextHop | Should -Be '192.168.1.1'
        }
        It "Gateway should respond to ping" {
            (Test-Connection (Get-NetIPConfiguration -InterfaceAlias 'Wifi').Ipv4DefaultGateway.NextHop -Count 1 -Quiet -ErrorAction SilentlyContinue ) | Should -Be $true
        }
    }
   <#
    Context "IIS"{
       ## It 'Should have IIS Feature' {
       ##     Get-WindowsFeature -ComputerName SQL2016N1 -Name Web-Server| Should -Be $True
       ## }
       ## It 'Should have IIS Management Tools' {
       ##     Get-WindowsFeature -ComputerName SQL2016N1 -Name Web-Mgmt-Tools| Should -Be $True
       ## }
       ## It 'Should have IIS Console' {
       ##     Get-WindowsFeature -ComputerName SQL2016N1 -Name Web-Mgmt-Console| Should -Be $True
       ## } 
        It 'The Default Website Should -Be Started' {
            $Scriptblock = {(get-website -Name 'Default Web Site').state }
            $State = Invoke-Command -ComputerName SQL2016N1 -ScriptBlock $Scriptblock 
            $State | Should -Be 'Started'
        }  
        It 'The Default App Pool should -Be started' {
            $State = Invoke-Command -ComputerName SQL2016N1 -ScriptBlock {(Get-WebAppPoolState -Name DefaultAppPool).Value}
            $State | Should -Be 'Started'
        }
        It "The website protocols should -Be http" {
            $Protocols = Invoke-Command -ComputerName SQL2016N1 -ScriptBlock {(Get-WebSite -Name 'Default Web Site').enabledProtocols}
            $Protocols  | Should -Be 'http'
        }
        It "The website path should -Be correct" {
            $Path = Invoke-Command -ComputerName SQL2016N1 -ScriptBlock {(Get-WebSite -Name 'Default Web Site').physicalPath}
            $Path | Should -Be '%SystemDrive%\inetpub\wwwroot'
        }        
    }
    #>
    Context "Programmes"{
        BeforeAll{
            $Programmes = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*
        }
        It "Should have Google Chrome" {
            $Programmes.Where{'Google Chrome'} | Should Not -BeNullOrEmpty
        }
        It "Should have SSMS 2016" {
            $Programmes.Where{$_.displayname -eq 'SQL Server 2016 Management Studio'} | Should Not -BeNullOrEmpty
        }
        It "Should have SSMS 17.4" {
            $Programmes.Where{$_.displayname -eq 'Microsoft SQL Server Management Studio - 17.4'} | Should Not -BeNullOrEmpty
        }
        It "SSMS 17.4 should be version 14.0.17213.0" {
            $Programmes.Where{$_.displayname -eq 'Microsoft SQL Server Management Studio - 17.4'}.DisplayVersion | Should -Be 14.0.17213.0
        }
    }
}
