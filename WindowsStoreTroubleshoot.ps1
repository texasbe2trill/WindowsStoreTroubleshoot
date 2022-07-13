$FolderPath="C:\Windows\SoftwareDistribution"
$DirectoryName = (Get-Date).tostring("MM-dd-yyyy HH")
taskkill /F /FI "SERVICES eq wuauserv";
taskkill /F /IM WinStore.App.exe;
net stop cryptSvc;
net stop bits;
net stop msiserver;
net stop wuauserv;
Rename-Item -Force -Path $FolderPath -newName ("SoftwareDistribution.bak "+ $DirectoryName);
Remove-Item -Force -ErrorAction SilentlyContinue -Recurse "C:\Windows\SoftwareDistribution\Download";
New-Item -ItemType Directory -Force C:\Windows\SoftwareDistribution\DataStore;
net stop appidsvc;
net start bits;
net start wuauserv;
net start cryptSvc;
net start wuauserv;
Write-Host "Done";
Write-Host "Restarting the system in 30 seconds!";
Start-Sleep -Seconds 30;
Restart-Computer