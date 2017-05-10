tzutil /s "Central Standard Time"

Install-WindowsFeature Web-Server
Install-WindowsFeature Web-Mgmt-Tools
Install-WindowsFeature Web-App-Dev -IncludeAllSubFeature
