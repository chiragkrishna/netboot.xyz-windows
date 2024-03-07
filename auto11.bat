@echo off
echo Removing restrictions
for %%s in (sCPU sSecureBoot sTPM) do reg add HKLM\SYSTEM\Setup\LabConfig /f /v Bypas%%sCheck /d 1 /t reg_dword
echo Initializing network
wpeinit
echo Connecting to Shared Drive
net use Z: \\10.11.12.10\server /user:name password
echo Running Setup.exe
Z:\docker_appdata\netbootxyz\assets\Win11\setup.exe
