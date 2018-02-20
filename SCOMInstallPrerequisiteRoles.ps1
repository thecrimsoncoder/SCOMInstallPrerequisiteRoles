<#
        SCOMInstallPrerequisiteRoles.ps1
        Description : Installs the prerequsite roles for SCOM on Windows Server 2012R2
        Author : Sean McElhare
        Date Created : 1/11/18
        Date Last Modified : 1/11/18
        NOTES : Run as Administrator
#>
Set-ExecutionPolicy -ExecutionPolicy Bypass;

$PrerequisiteRoles = @(
                       "NET-Framework-Core",
                       "AS-HTTP-Activation",
                       "Web-Static-Content",
                       "Web-Default-Doc",
                       "Web-Dir-Browsing",
                       "Web-Http-Errors",
                       "Web-Http-Logging",
                       "Web-Request-Monitor",
                       "Web-Filtering",
                       "Web-Stat-Compression",
                       "AS-Web-Support",
                       "Web-Metabase",
                       "Web-Asp-Net",
                       "Web-Windows-Auth"
                      );

$successfulInstall = $true

foreach($Role in $PrerequisiteRoles)
{
    $installFeature = "Add-WindowsFeature $Role -WhatIf";

    try {
        iex($installFeature);

    }
    catch {
        echo("$Role could not be installed");
    }
}
if($successfulInstall -eq $true)
{
    echo("Install of SCOM prerequsite roles was Successful, Now restarting the server!");
    Start-Sleep -s 5;
    Restart-Computer -confirm;
}
else {
    echo("Install of SCOM prerequsite roles was UnSuccessful");
}