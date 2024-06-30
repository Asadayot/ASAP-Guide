@ECHO OFF
mode con: cols=101 lines=32
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 949 >nul 2>&1
title ASAP Install Supporter

COLOR 09
set wd=%temp%\sdfiles
set sd=%1

REM ============================================================
:TITLE
COLOR 09
cls
echo -----------------------------------------------------------------------------------------------------
echo =====================================================================================================
echo.
echo.
echo           .....                                    .....               .....                       
echo          .oXXXXOdc,.             cOOkdl:,..       ,0XXXKko;..         lKXXX0xc,.                   
echo          .xMMMMMMMWKko:'.      .oNMMMMMMWXKOxo:.  :XMMMMMMWX0dc,.     dWMMMMMMWXOd:'.              
echo          .xMMMWXXWMMMMWN0xc.  .dNMMWXKNWMMMMMM0'  :XMMMNKNWMMMMWXOo;  dWMMWXXWMMMMMNKkl'           
echo          .xMMMK:.;lx0NWMMMWo .dWMMMNx,',:ldk00l   :XMMWd.':oOXWMMMM0, dWMMXc.,cd0XWMMMMx.          
echo          .xMMMK,    .'dNMMWd  ;kNMMMWOc.    ..    :XMMWo     .:KMMMK, dWMMX:     .oNMMMk.          
echo          .xMMMK,      :XMMWd    ,xXMMMW0l.        :XMMWo      .kMMMK, dWMMX:      ,KMMMk.          
echo          .xMMMK;      cNMMWd      'oKWMMWXd,      :XMMWd.     .OMMMK, dWMMXc      ;KMMMk.          
echo          .xMMMWKOOOOOOKWMMWd        .l0WMMMNk;.   :XMMMX0OOOOO0NMMMK, dWMMWXOOOOOOKWMMMk.          
echo          .xMMMMMMMMMMMMMMMWd  .,;'.   .:ONMMMNk.  :XMMMMMMMMMMMMMMMK, dWMMMMMMMMMMMMMMMk.          
echo          .xMMMNOdddddd0WMMWd  lNWNK0kdl:oXMMMWx.  :XMMMKxdddddkXMMMK, dWMMW0ddddddddddd;           
echo          .xMMMK,      :XMMWd .xNWMMMMMMMWMMMNo.   :XMMWo      .kMMMK, dWMMX:                       
echo          .xMMMK,      :XMMWo  .';coxOKNWMMMXl.    :XMMWo      .kMMM0, oWMMX;                       
echo           'clc;.      .:ccc.         ..,:lo;      .:clc.       'ccc;. .ccl:. 
echo.
echo.        
echo           Asa's Switch Aio Package                                               
echo           As Soon As Possible                                                   
echo.		
echo           Command: AIS ^> LOGO ^> MAKE ^> SPLASH ^> PACK or ASAP / HATS, KEFIR, DEEPSEA  							  
echo.			
echo =====================================================================================================					  
echo -----------------------------------------------------------------------------------------------------
echo.

set /p TITLE="     - Press Enter key to install SD Card or enter command: "
if "%TITLE%"=="" exit
if /i "%TITLE%"=="EXIT" exit
if /i "%TITLE%"=="PACK" GOTO PACK
if /i "%TITLE%"=="ASAP" GOTO ASAP
if /i "%TITLE%"=="HATS" GOTO HATS
if /i "%TITLE%"=="KEFIR" GOTO KEFIR
if /i "%TITLE%"=="DEEPSEA" GOTO DEEPSEA
if /i "%TITLE%"=="MAKE" GOTO MAKE
if /i "%TITLE%"=="LOGO" GOTO LOGO
if /i "%TITLE%"=="SPLASH" GOTO SPLASH
if /i "%TITLE%"=="AIS" GOTO AIS
pause>nul 2>&1

REM ============================================================
:NOTICE
COLOR 0C
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                                             - Notice - 
echo.
echo                              This batch file is for developers only.
echo.
echo.                                                                                         B = Title
echo -----------------------------------------------------------------------------------------------------
echo.

for /f "usebackq delims=" %%a in (`powershell -command "$ErrorActionPreference='Stop'; $sd = Get-WmiObject -Class Win32_Volume | Where-Object {$_.DriveType -eq 2}; foreach ($s in $sd) { '- Drive found: {0}' -f $s.DriveLetter; if ($s.Label) { '- Drive Name: {0}' -f $s.Label }; '- Format: {0}' -f $s.FileSystem; $size = [math]::Round($s.Capacity / 1GB, 2); if ($size -ge 1) { '- Volume: {0} GB' -f $size } else { '- Volume: {0} MB' -f ($s.Capacity / 1MB) }; '- Used: {0} GB' -f ([math]::Round(($s.Capacity - $s.FreeSpace) / 1GB, 2)); '- Empty: {0} GB' -f ([math]::Round($s.FreeSpace / 1GB, 2)) }"`) do (
    echo %%a
)

echo.

set /p "sd=     - Micro SD Card Drive letter: "

if not exist "%sd%:\" (
	set word=      No Micro SD Card: %sd%         
	GOTO NOTMATCHDRIVE
) else (
	if not exist "%sd%:\*" (
	  GOTO NOTMATCHDRIVE
	  )
)
if /i "%NOTICE%"=="B" GOTO TITLE

REM ============================================================
:BACKUP
COLOR 0A
cls
echo -----------------------------------------------------------------------------------------------------  
echo.
echo                        Backing up important files, please wait a moment...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
powershell -Command "Start-Sleep -Seconds 3"

set "BackupFolder=%sd%:\Backup"
set "AB=%BackupFolder%\"

if not exist "%AB%" (
    mkdir "%AB%" >nul 2>&1
)

set "folders=keys kips savedata tinfoil"

for %%i in (%folders%) do (
    if not exist "%AB%\%%i" (
        mkdir "%AB%\%%i" >nul 2>&1
    )
)

if exist "%sd%:\atmosphere\automatic_backups\*" (
xcopy /I /Y "%sd%:\atmosphere\automatic_backups\*" "%AB%\keys\automatic_backups\" >nul 2>&1
)
if exist "%sd%:\atmosphere\bluetooth_devices.db" (
xcopy /I /Y "%sd%:\atmosphere\bluetooth_devices.db" "%AB%\" >nul 2>&1
)
if exist "%sd%:\atmosphere\kips\loader.kip" (
xcopy /I /Y "%sd%:\atmosphere\kips\loader.kip" "%AB%\kips\" >nul 2>&1
)
if exist "%sd%:\emuiibo" (
xcopy /H /Y /C /R /S /E /I "%sd%:\emuiibo" "%AB%\emuiibo" >nul 2>&1
)
if exist "%sd%:\SaltySD" (
xcopy /H /Y /C /R /S /E /I "%sd%:\SaltySD" "%AB%\SaltySD" >nul 2>&1
)
if exist "%sd%:\savedata\*" (
xcopy /I /Y "%sd%:\savedata\*" "%AB%\savedata\" >nul 2>&1
)
if exist "%sd%:\savedata\DBI" (
xcopy /I /Y "%sd%:\savedata\DBI" "%AB%\savedata\" >nul 2>&1
)
if exist "%sd%:\JKSV\*" (
xcopy /I /Y "%sd%:\JKSV\*" "%AB%\savedata\" >nul 2>&1
)
if exist "%sd%:\config\JKSV\webdav.json" (
xcopy /I /Y "%sd%:\config\JKSV\webdav.json" "%AB%\" >nul 2>&1
)
if exist "%sd%:\switch\prod.keys" (
xcopy /I /Y "%sd%:\switch\prod.keys" "%AB%\keys\" >nul 2>&1
)
if exist "%sd%:\switch\title.keys" (
xcopy /I /Y "%sd%:\switch\title.keys" "%AB%\keys\" >nul 2>&1
)
if exist "%sd%:\switch\dev.keys" (
xcopy /I /Y "%sd%:\switch\dev.keys" "%AB%\keys\" >nul 2>&1
)
if exist "%sd%:\switch\partial_aes.keys" (
xcopy /I /Y "%sd%:\switch\partial_aes.keys" "%AB%\keys\" >nul 2>&1
)
if exist "%sd%:\switch\key_retail.bin" (
xcopy /I /Y "%sd%:\switch\switch\key_retail.bin" "%AB%\keys\" >nul 2>&1
)
if exist "%sd%:\switch\tinfoil\locations.conf" (
xcopy /I /Y "%sd%:\switch\tinfoil\locations.conf" "%AB%\Tinfoil\" >nul 2>&1
)
if exist "%sd%:\switch\tinfoil\options.json" (
xcopy /I /Y "%sd%:\switch\tinfoil\options.json" "%AB%\Tinfoil\" >nul 2>&1
)

if exist "%sd%:\atmosphere\titles" (rename %sd%:\atmosphere\titles contents)
if exist "%sd%:\atmosphere\title" (rename %sd%:\atmosphere\title contents)
if exist "%sd%:\atmosphere\content" (rename %sd%:\atmosphere\content contents)

REM ======= ATMOSPHERE CONTENTS ================================
if exist "%sd%:\atmosphere\config" (RD /S /Q "%sd%:\atmosphere\config")
if exist "%sd%:\atmosphere\config_templates" (RD /S /Q "%sd%:\atmosphere\config_templates")

if exist "%sd%:\atmosphere\contents\0100000000000008" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000008")
if exist "%sd%:\atmosphere\contents\010000000000100B" (RD /S /Q "%sd%:\atmosphere\contents\010000000000100B")
if exist "%sd%:\atmosphere\contents\010000000000000D" (RD /S /Q "%sd%:\atmosphere\contents\010000000000000D")
if exist "%sd%:\atmosphere\contents\010000000000002b" (RD /S /Q "%sd%:\atmosphere\contents\010000000000002b")
if exist "%sd%:\atmosphere\contents\0100000000000032" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000032")
if exist "%sd%:\atmosphere\contents\0100000000000034" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000034")
if exist "%sd%:\atmosphere\contents\0100000000000036" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000036")
if exist "%sd%:\atmosphere\contents\0100000000000037" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000037")
if exist "%sd%:\atmosphere\contents\010000000000003C" (RD /S /Q "%sd%:\atmosphere\contents\010000000000003C")
if exist "%sd%:\atmosphere\contents\0100000000000042" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000042")
if exist "%sd%:\atmosphere\contents\010000000000100C" (RD /S /Q "%sd%:\atmosphere\contents\010000000000100C")
if exist "%sd%:\atmosphere\contents\010000000000100D" (RD /S /Q "%sd%:\atmosphere\contents\010000000000100D")
if exist "%sd%:\atmosphere\contents\0100000000001000" (RD /S /Q "%sd%:\atmosphere\contents\0100000000001000")
if exist "%sd%:\atmosphere\contents\0100000000001013" (RD /S /Q "%sd%:\atmosphere\contents\0100000000001013")
if exist "%sd%:\atmosphere\contents\0000000000534C56" (RD /S /Q "%sd%:\atmosphere\contents\0000000000534C56")
if exist "%sd%:\atmosphere\contents\00FF0000000002AA" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000000002AA")
if exist "%sd%:\atmosphere\contents\00FF0000636C6BF2" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000636C6BF2")
if exist "%sd%:\atmosphere\contents\00FF0000636C6BFF" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000636C6BFF")
if exist "%sd%:\atmosphere\contents\00FF00006D7470FF" (RD /S /Q "%sd%:\atmosphere\contents\00FF00006D7470FF")
if exist "%sd%:\atmosphere\contents\00FF0000A53BB665" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000A53BB665")
if exist "%sd%:\atmosphere\contents\00FF0012656180FF" (RD /S /Q "%sd%:\atmosphere\contents\00FF0012656180FF")
if exist "%sd%:\atmosphere\contents\01FF415446660000" (RD /S /Q "%sd%:\atmosphere\contents\01FF415446660000")
if exist "%sd%:\atmosphere\contents\00FF747765616BFF" (RD /S /Q "%sd%:\atmosphere\contents\00FF747765616BFF")
if exist "%sd%:\atmosphere\contents\0100000000000052" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000052")
if exist "%sd%:\atmosphere\contents\0100000000000081" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000081")
if exist "%sd%:\atmosphere\contents\0100000000000352" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000352")
if exist "%sd%:\atmosphere\contents\0100000000000464" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000464")
if exist "%sd%:\atmosphere\contents\0100000000000523" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000523")
if exist "%sd%:\atmosphere\contents\0100000000000901" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000901")
if exist "%sd%:\atmosphere\contents\0100000000000BED" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000BED")
if exist "%sd%:\atmosphere\contents\0100000000000BEF" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000BEF")
if exist "%sd%:\atmosphere\contents\0100000000000DAD" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000DAD")
if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000F12")
if exist "%sd%:\atmosphere\contents\0100000000000FAF" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000FAF")
if exist "%sd%:\atmosphere\contents\0100000000006480" (RD /S /Q "%sd%:\atmosphere\contents\0100000000006480")
if exist "%sd%:\atmosphere\contents\0100000000007200" (RD /S /Q "%sd%:\atmosphere\contents\0100000000007200")
if exist "%sd%:\atmosphere\contents\010000000000bd00" (RD /S /Q "%sd%:\atmosphere\contents\010000000000bd00")
if exist "%sd%:\atmosphere\contents\010000000000C235" (RD /S /Q "%sd%:\atmosphere\contents\010000000000C235")
if exist "%sd%:\atmosphere\contents\010000000000f00f" (RD /S /Q "%sd%:\atmosphere\contents\010000000000f00f")
if exist "%sd%:\atmosphere\contents\010000000000FFAB" (RD /S /Q "%sd%:\atmosphere\contents\010000000000FFAB")
if exist "%sd%:\atmosphere\contents\01000000001ED1ED" (RD /S /Q "%sd%:\atmosphere\contents\01000000001ED1ED")
if exist "%sd%:\atmosphere\contents\0532232232232000" (RD /S /Q "%sd%:\atmosphere\contents\0532232232232000")
if exist "%sd%:\atmosphere\contents\054e4f4558454000" (RD /S /Q "%sd%:\atmosphere\contents\054e4f4558454000")
if exist "%sd%:\atmosphere\contents\2200000000000100" (RD /S /Q "%sd%:\atmosphere\contents\2200000000000100")
if exist "%sd%:\atmosphere\contents\4100000000000324" (RD /S /Q "%sd%:\atmosphere\contents\4100000000000324")
if exist "%sd%:\atmosphere\contents\4200000000000000" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000000")
if exist "%sd%:\atmosphere\contents\4200000000000010" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000010")
if exist "%sd%:\atmosphere\contents\420000000000000E" (RD /S /Q "%sd%:\atmosphere\contents\420000000000000E")
if exist "%sd%:\atmosphere\contents\420000000000000F" (RD /S /Q "%sd%:\atmosphere\contents\420000000000000F")
if exist "%sd%:\atmosphere\contents\4200000000000811" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000811")
if exist "%sd%:\atmosphere\contents\4200000000000BA6" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000BA6")
if exist "%sd%:\atmosphere\contents\4200000000000FFF" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000FFF")
if exist "%sd%:\atmosphere\contents\010000000007E51A" (RD /S /Q "%sd%:\atmosphere\contents\010000000007E51A")
if exist "%sd%:\atmosphere\contents\420000000007E51A" (RD /S /Q "%sd%:\atmosphere\contents\420000000007E51A")
if exist "%sd%:\atmosphere\contents\4200000000474442" (RD /S /Q "%sd%:\atmosphere\contents\4200000000474442")
if exist "%sd%:\atmosphere\contents\4200000000696969" (RD /S /Q "%sd%:\atmosphere\contents\4200000000696969")
if exist "%sd%:\atmosphere\contents\4200000AF1E8DA89" (RD /S /Q "%sd%:\atmosphere\contents\4200000AF1E8DA89")
if exist "%sd%:\atmosphere\contents\42000062616B6101" (RD /S /Q "%sd%:\atmosphere\contents\42000062616B6101")
if exist "%sd%:\atmosphere\contents\4200736372697074" (RD /S /Q "%sd%:\atmosphere\contents\4200736372697074")
if exist "%sd%:\atmosphere\contents\4206900000000012" (RD /S /Q "%sd%:\atmosphere\contents\4206900000000012")
if exist "%sd%:\atmosphere\contents\430000000000000A" (RD /S /Q "%sd%:\atmosphere\contents\430000000000000A")
if exist "%sd%:\atmosphere\contents\430000000000000B" (RD /S /Q "%sd%:\atmosphere\contents\430000000000000B")
if exist "%sd%:\atmosphere\contents\430000000000000C" (RD /S /Q "%sd%:\atmosphere\contents\430000000000000C")
if exist "%sd%:\atmosphere\contents\43000000000000FF" (RD /S /Q "%sd%:\atmosphere\contents\43000000000000FF")
if exist "%sd%:\atmosphere\contents\4300000000000909" (RD /S /Q "%sd%:\atmosphere\contents\4300000000000909")
if exist "%sd%:\atmosphere\contents\5600000000000000" (RD /S /Q "%sd%:\atmosphere\contents\5600000000000000")
if exist "%sd%:\atmosphere\contents\690000000000000D" (RD /S /Q "%sd%:\atmosphere\contents\690000000000000D")

if exist "%sd%:\atmosphere\exefs_patches" (RD /S /Q "%sd%:\atmosphere\exefs_patches")
if exist "%sd%:\atmosphere\fatal_errors" (RD /S /Q "%sd%:\atmosphere\fatal_errors")
if exist "%sd%:\atmosphere\flags" (RD /S /Q "%sd%:\atmosphere\flags")
if exist "%sd%:\atmosphere\hb" (RD /S /Q "%sd%:\atmosphere\hb")
if exist "%sd%:\atmosphere\hbl_html" (RD /S /Q "%sd%:\atmosphere\hbl_html")
if exist "%sd%:\atmosphere\hosts" (RD /S /Q "%sd%:\atmosphere\hosts")
if exist "%sd%:\atmosphere\kip_patches" (RD /S /Q "%sd%:\atmosphere\kip_patches")
if exist "%sd%:\atmosphere\kips" (RD /S /Q "%sd%:\atmosphere\kips")
if exist "%sd%:\atmosphere\logs" (RD /S /Q "%sd%:\atmosphere\logs")

if exist "%sd%:\atmosphere\erpt_reports" (RD /S /Q "%sd%:\atmosphere\erpt_reports")
if exist "%sd%:\atmosphere\fatal_reports" (RD /S /Q "%sd%:\atmosphere\fatal_reports")
if exist "%sd%:\atmosphere\crash_reports" (RD /S /Q "%sd%:\atmosphere\crash_reports")

if exist "%sd%:\atmosphere\*.aio" (DEL /F "%sd%:\atmosphere\*.aio")
if exist "%sd%:\atmosphere\*.bat" (DEL /F "%sd%:\atmosphere\*.bat")
if exist "%sd%:\atmosphere\*.bin" (DEL /F "%sd%:\atmosphere\*.bin")
if exist "%sd%:\atmosphere\*.dat" (DEL /F "%sd%:\atmosphere\*.dat")
if exist "%sd%:\atmosphere\*.db" (DEL /F "%sd%:\atmosphere\*.db")
if exist "%sd%:\atmosphere\*.enc" (DEL /F "%sd%:\atmosphere\*.enc")
if exist "%sd%:\atmosphere\*.git" (DEL /F "%sd%:\atmosphere\*.git")
if exist "%sd%:\atmosphere\*.ini" (DEL /F "%sd%:\atmosphere\*.ini")
if exist "%sd%:\atmosphere\*.log" (DEL /F "%sd%:\atmosphere\*.log")
if exist "%sd%:\atmosphere\*.md" (DEL /F "%sd%:\atmosphere\*.md")
if exist "%sd%:\atmosphere\*.nro" (DEL /F "%sd%:\atmosphere\*.nro")
if exist "%sd%:\atmosphere\*.nsp" (DEL /F "%sd%:\atmosphere\*.nsp")
if exist "%sd%:\atmosphere\*.romfs" (DEL /F "%sd%:\atmosphere\*.romfs")
if exist "%sd%:\atmosphere\*.star" (DEL /F "%sd%:\atmosphere\*.star")
if exist "%sd%:\atmosphere\*.te" (DEL /F "%sd%:\atmosphere\*.te")
if exist "%sd%:\atmosphere\*.txt" (DEL /F "%sd%:\atmosphere\*.txt")
if exist "%sd%:\atmosphere\*.zip" (DEL /F "%sd%:\atmosphere\*.zip")
if exist "%sd%:\atmosphere\package3" (DEL /F "%sd%:\atmosphere\package3")

if exist "%sd%:\bootloader" (RD /S /Q "%sd%:\bootloader")
if exist "%sd%:\config" (RD /S /Q "%sd%:\config")
if exist "%sd%:\nsp" (RD /S /Q "%sd%:\nsp")
if exist "%sd%:\PlusPack" (RD /S /Q "%sd%:\PlusPack")

if exist "%sd%:\switch\.overlays" (RD /S /Q "%sd%:\switch\.overlays")
if exist "%sd%:\switch\.packages" (RD /S /Q "%sd%:\switch\.packages")
if exist "%sd%:\switch\appstore" (RD /S /Q "%sd%:\switch\appstore")
if exist "%sd%:\switch\Daybreak" (RD /S /Q "%sd%:\switch\Daybreak")
if exist "%sd%:\switch\Haze" (RD /S /Q "%sd%:\switch\Haze")
if exist "%sd%:\switch\JKSV" (RD /S /Q "%sd%:\switch\JKSV")
if exist "%sd%:\switch\ldnmitm_config" (RD /S /Q "%sd%:\switch\ldnmitm_config")
if exist "%sd%:\switch\Linkalho" (RD /S /Q "%sd%:\switch\Linkalho")
if exist "%sd%:\switch\NXDumpTool" (RD /S /Q "%sd%:\switch\NXDumpTool")
if exist "%sd%:\switch\NX-Activity-Log" (RD /S /Q "%sd%:\switch\NX-Activity-Log")
if exist "%sd%:\switch\ReverseNX-Tool" (RD /S /Q "%sd%:\switch\ReverseNX-Tool")
if exist "%sd%:\switch\sigpatch-updater" (RD /S /Q "%sd%:\switch\sigpatch-updater")
if exist "%sd%:\switch\SPU" (RD /S /Q "%sd%:\switch\SPU")
if exist "%sd%:\switch\sys-clk-manager" (RD /S /Q "%sd%:\switch\sys-clk-manager")

if exist "%sd%:\switch\*.aio" (DEL /F "%sd%:\switch\*.aio")
if exist "%sd%:\switch\*.bat" (DEL /F "%sd%:\switch\*.bat")
if exist "%sd%:\switch\*.bin" (DEL /F "%sd%:\switch\*.bin")
if exist "%sd%:\switch\*.dat" (DEL /F "%sd%:\switch\*.dat")
if exist "%sd%:\switch\*.enc" (DEL /F "%sd%:\switch\*.enc")
if exist "%sd%:\switch\*.git" (DEL /F "%sd%:\switch\*.git")
if exist "%sd%:\switch\*.ini" (DEL /F "%sd%:\switch\*.ini")
if exist "%sd%:\switch\*.keys" (DEL /F "%sd%:\switch\*.keys")
if exist "%sd%:\switch\*.log" (DEL /F "%sd%:\switch\*.log")
if exist "%sd%:\switch\*.md" (DEL /F "%sd%:\switch\*.md")
if exist "%sd%:\switch\*.nro" (DEL /F "%sd%:\switch\*.nro")
if exist "%sd%:\switch\*.nsp" (DEL /F "%sd%:\switch\*.nsp")
if exist "%sd%:\switch\*.romfs" (DEL /F "%sd%:\switch\*.romfs")
if exist "%sd%:\switch\*.star" (DEL /F "%sd%:\switch\*.star")
if exist "%sd%:\switch\*.te" (DEL /F "%sd%:\switch\*.te")
if exist "%sd%:\switch\*.txt" (DEL /F "%sd%:\switch\*.txt")
if exist "%sd%:\switch\*.zip" (DEL /F "%sd%:\switch\*.zip")

if exist "%sd%:\ams" (RD /S /Q "%sd%:\ams")
if exist "%sd%:\atmo" (RD /S /Q "%sd%:\atmo")
if exist "%sd%:\firmware" (RD /S /Q "%sd%:\firmware")
if exist "%sd%:\games" (RD /S /Q "%sd%:\games")
if exist "%sd%:\music" (RD /S /Q "%sd%:\music")
if exist "%sd%:\modules" (RD /S /Q "%sd%:\modules")
if exist "%sd%:\NSPs" (RD /S /Q "%sd%:\NSPs")
if exist "%sd%:\pegascape" (RD /S /Q "%sd%:\pegascape")
if exist "%sd%:\sept" (RD /S /Q  "%sd%:\sept")
if exist "%sd%:\scripts" (RD /S /Q "%sd%:\scripts")
if exist "%sd%:\sxos" (RD /S /Q  "%sd%:\sxos")
if exist "%sd%:\tegraexplorer" (RD /S /Q "%sd%:\tegraexplorer")
if exist "%sd%:\TinGen" (RD /S /Q "%sd%:\TinGen")
if exist "%sd%:\themes" (RD /S /Q "%sd%:\themes")
if exist "%sd%:\tools" (RD /S /Q "%sd%:\tools")
if exist "%sd%:\warmboot_mariko" (RD /S /Q "%sd%:\warmboot_mariko")


REM ======= Micro SD ROOT ======================================
if exist "%sd%:\*.aio" (DEL /F "%sd%:\*.aio")
if exist "%sd%:\*.bat" (DEL /F "%sd%:\*.bat")
if exist "%sd%:\*.bin" (DEL /F "%sd%:\*.bin")
if exist "%sd%:\*.dat" (DEL /F "%sd%:\*.dat")
if exist "%sd%:\*.enc" (DEL /F "%sd%:\*.enc")
if exist "%sd%:\*.git" (DEL /F "%sd%:\*.git")
if exist "%sd%:\*.ini" (DEL /F "%sd%:\*.ini")
if exist "%sd%:\*.log" (DEL /F "%sd%:\*.log")
if exist "%sd%:\*.md" (DEL /F "%sd%:\*.md")
if exist "%sd%:\*.nro" (DEL /F "%sd%:\*.nro")
if exist "%sd%:\*.nsp" (DEL /F "%sd%:\*.nsp")
if exist "%sd%:\*.romfs" (DEL /F "%sd%:\*.romfs")
if exist "%sd%:\*.star" (DEL /F "%sd%:\*.star")
if exist "%sd%:\*.te" (DEL /F "%sd%:\*.te")
if exist "%sd%:\*.txt" (DEL /F "%sd%:\*.txt")

FOR /D /R "%sd%:\" %%X IN (amsPACK*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (kefir*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (ShallowSea*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (DeepSea*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (reinx*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (firmware*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (sxos*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (custom*) DO RD /S /Q "%%X"

GOTO STANDARD

REM ============================================================
:MAKE

@echo off
cd /d "%~dp0"

REM symbolic head error quick fix
%~dp0msys64\mingw64.exe bash -c "rm -rf Atmosphere && git clone --recursive -b test https://github.com/Yorunokyujitsu/Atmosphere"
%~dp0msys64\mingw64.exe bash -c "rm -rf programs/sysmodules/MissionControl && git clone --recursive https://github.com/Yorunokyujitsu/MissionControl programs/sysmodules/MissionControl"
%~dp0msys64\mingw64.exe bash -c "rm -rf programs/sysmodules/sys-con && git clone --recursive https://github.com/Yorunokyujitsu/sys-con programs/sysmodules/sys-con"

%~dp0msys64\mingw64.exe %~dp0build.sh

GOTO TITLE

REM ============================================================
:PACK

if exist "%~dp0output\direct" (RD /S /Q "%~dp0output\direct")
@echo off
cd /d "%~dp0"
%~dp0msys64\mingw64.exe %~dp0pack.sh

GOTO NOTICE

REM ============================================================
:LOGO

@echo off
cd atmo_logo_creator
python .\scripts\create_logos.py
cd ..
xcopy "%~dp0atmo_logo_creator\output\stratosphere" "%~dp0atmosphere\stratosphere" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%~dp0atmo_logo_creator\output" (RD /S /Q "%~dp0atmo_logo_creator\output")

GOTO TITLE

REM ============================================================
:SPLASH

if exist "%~dp0Atmosphere\img\splash.bin" (DEL /F "%~dp0Atmosphere\img\splash.bin")
xcopy "%~dp0Atmosphere\out\nintendo_nx_arm64_armv8a\release\atmosphere-out\atmosphere\package3" "%~dp0Atmosphere\utilities\" /H /Y /C /R /S /I >nul 2>nul
@echo off
cd Atmosphere\utilities
python .\insert_splash_screen.py %~dp0Atmosphere\img\splash.png %~dp0Atmosphere\utilities\package3
xcopy "%~dp0Atmosphere\utilities\splash.bin" "%~dp0Atmosphere\img\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0Atmosphere\utilities\splash.bin" (DEL /F "%~dp0Atmosphere\utilities\splash.bin")
if exist "%~dp0Atmosphere\utilities\package3" (DEL /F "%~dp0Atmosphere\utilities\package3")

cd /d "%~dp0"
%~dp0msys64\mingw64.exe %~dp0Atmosphere\splash.sh

GOTO TITLE

REM ============================================================
:AIS

@echo off
cd AIS
pip install pyinstaller tk pillow psutil numpy
pyinstaller -F -w -n=ASAP --version-file=.\details_info.py --icon=.\resources\app_icon\icon_256x256.ico .\AIS.py
xcopy "%~dp0AIS\dist\ASAP.exe" "%~dp0output\AIS\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0AIS\build" (RD /S /Q "%~dp0AIS\build")
if exist "%~dp0AIS\dist" (RD /S /Q "%~dp0AIS\dist")
if exist "%~dp0AIS\ASAP.spec" (DEL /F "%~dp0AIS\ASAP.spec")
pyinstaller -F -w -n=ASAP --version-file=.\details_info.py --icon=.\resources\app_icon\icon_256x256.ico .\AIS_test.py
xcopy "%~dp0AIS\dist\ASAP.exe" "%~dp0output\tester\" /H /Y /C /R /S /I >nul 2>nul
cd ..
if exist "%~dp0AIS\build" (RD /S /Q "%~dp0AIS\build")
if exist "%~dp0AIS\dist" (RD /S /Q "%~dp0AIS\dist")
if exist "%~dp0AIS\ASAP.spec" (DEL /F "%~dp0AIS\ASAP.spec")

GOTO TITLE

REM ============================================================
:STANDARD
COLOR 0A
echo -----------------------------------------------------------------------------------------------------
echo.
echo                                            Installing...
echo.
echo =====================================================================================================

xcopy "%~dp0output\direct\*" "%sd%:\" /H /Y /C /R /S /I >nul 2>nul

GOTO HEKATEUSB

REM ============================================================
:ASAP

@echo off
set version_file=%~dp0version
for /f "tokens=1 delims=|" %%a in (%version_file%) do set hekate_ver=%%a
for /f "tokens=2 delims=|" %%a in (%version_file%) do set asap_ver=%%a
for /f "tokens=3 delims=|" %%a in (%version_file%) do set type=%%a

cls
REM ASAP-NORMAL
REM ASAP folder
xcopy "%~dp0programs\overlays\Ultrahand-Overlay\Packages\*" "%~dp0ASAP-PACKAGE\ASAP\ASAP-assist\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\MissionControl\dist\MissionControl" "%~dp0ASAP-PACKAGE\ASAP\ASAP-assist\Controller\MissionControl" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\sys-con\out\atmosphere\contents\690000000000000D" "%~dp0ASAP-PACKAGE\ASAP\ASAP-assist\Controller\sys-con\690000000000000D" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\sys-con\out\config\sys-con" "%~dp0ASAP-PACKAGE\ASAP\ASAP-assist\Controller\sys-con\sys-con" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\sys-con\out\switch" "%~dp0ASAP-PACKAGE\ASAP\ASAP-assist\Controller\sys-con\switch" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\homebrews\JKSV\JKSV.nro" "%~dp0ASAP-PACKAGE\ASAP\ASAP-assist\Homebrews\JKSV\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\homebrews\Linkalho\linkalho.nro" "%~dp0ASAP-PACKAGE\ASAP\ASAP-assist\Homebrews\Linkalho\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0Atmosphere\config_templates\cloader\eosloader\loader.kip" "%~dp0ASAP-PACKAGE\backup\kips\.EOS\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0Atmosphere\config_templates\cloader\scloader\loader.kip" "%~dp0ASAP-PACKAGE\backup\kips\.SC\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\sys-clk\sys-clk-oc\atmosphere\contents\00FF0000636C6BFF" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\00FF0000636C6BFF" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0Atmosphere\out\nintendo_nx_arm64_armv8a\release\atmosphere-out\atmosphere" "%~dp0ASAP-PACKAGE\ASAP\atmosphere" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0ATLAS\output\atmosphere" "%~dp0ASAP-PACKAGE\ASAP\atmosphere" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\patches\sys-patch\out\atmosphere\contents\420000000000000B\flags\boot2.flag" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\010B6ECF3B30D000\02\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\patches\sys-patch\out\atmosphere\contents\420000000000000B\exefs.nsp" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\010B6ECF3B30D000\02\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\SaltySD\0000000000534C56" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\0000000000534C56" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\overlays\420000000007E51A" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\420000000007E51A" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\emuiibo\boot2.flag" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\0100000000000352\flags\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\emuiibo\exefs.nsp" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\0100000000000352\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\emuiibo\toolbox.json" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\0100000000000352\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hb\hbmenu\hbmenu.nro" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\hb\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hb\nx-hbloader\hbl.nsp" "%~dp0ASAP-PACKAGE\ASAP\atmosphere\hb\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\overlay\lang" "%~dp0ASAP-PACKAGE\ASAP\emuiibo\overlay\lang" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\favorites.txt" "%~dp0ASAP-PACKAGE\ASAP\emuiibo\overlay\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\homebrews\JKSV\webdav.json" "%~dp0ASAP-PACKAGE\ASAP\JKSV\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\SaltySD\SaltySD" "%~dp0ASAP-PACKAGE\ASAP\SaltySD" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0ASAP-Updater\ASAP-Updater.nro" "%~dp0ASAP-PACKAGE\ASAP\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\sys-clk\sys-clk-oc\config\sys-clk\config.ini" "%~dp0ASAP-PACKAGE\ASAP\" /H /Y /C /R /S /I >nul 2>nul
REM bootloader folder
xcopy "%~dp0Atmosphere\out\nintendo_nx_arm64_armv8a\release\atmosphere-out\bootloader" "%~dp0ASAP-PACKAGE\bootloader" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0ATLAS\output\bootloader" "%~dp0ASAP-PACKAGE\bootloader" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0hekate\CTCaer" "%~dp0ASAP-PACKAGE\bootloader" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0ASAP-Updater\ATLAS\output\ATLAS.bin" "%~dp0ASAP-PACKAGE\bootloader\payloads\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hekate\output\libsys_lp0.bso" "%~dp0ASAP-PACKAGE\bootloader\sys\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hekate\output\libsys_minerva.bso" "%~dp0ASAP-PACKAGE\bootloader\sys\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hekate\output\nyx.bin" "%~dp0ASAP-PACKAGE\bootloader\sys\" /H /Y /C /R /S /I >nul 2>nul
REM nsp folder
xcopy "%~dp0SAK\output\nsp" "%~dp0ASAP-PACKAGE\nsp" /H /Y /C /R /S /E /I >nul 2>nul
REM switch folder
xcopy "%~dp0programs\sys-clk\sys-clk-oc\switch" "%~dp0ASAP-PACKAGE\switch" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0Atmosphere\out\nintendo_nx_arm64_armv8a\release\atmosphere-out\switch" "%~dp0ASAP-PACKAGE\switch" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\overlay\emuiibo.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\.offload\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\FPSLocker\FPSLocker.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\EdiZon-Overlay\out\ovlEdiZon.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\Ultrahand-Overlay\ovlmenu.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\ovl-sysmodules\ovlSysmodules.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\ReverseNX-RT\Out\switch\.overlays\ReverseNX-RT-ovl.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\Status-Monitor-Overlay\Status-Monitor-Overlay.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0ASAP-Updater\.ASAP-Updater.nro.star" "%~dp0ASAP-PACKAGE\switch\ASAP-Updater\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\homebrews\DBI" "%~dp0ASAP-PACKAGE\switch\DBI" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\homebrews\Tinfoil" "%~dp0ASAP-PACKAGE\switch\Tinfoil" /H /Y /C /R /S /E /I >nul 2>nul
REM warmboot_mariko folder
xcopy "%~dp0Atmosphere\out\nintendo_nx_arm64_armv8a\release\atmosphere-out\warmboot_mariko" "%~dp0ASAP-PACKAGE\warmboot_mariko" /H /Y /C /R /S /E /I >nul 2>nul
REM SX_Gear files
xcopy "%~dp0misc\modchip\SX\SX_Gear\*" "%~dp0ASAP-PACKAGE\" /H /Y /C /R /S /I >nul 2>nul
REM payload file
xcopy "%~dp0hekate\CTCaer\hekate.bin" "%~dp0ASAP-PACKAGE\" /H /Y /C /R /S /I >nul 2>nul
REM rename files
if exist "%~dp0ASAP-PACKAGE\bootloader\hekate.bin" (rename %~dp0ASAP-PACKAGE\bootloader\hekate.bin update.bin)
if exist "%~dp0ASAP-PACKAGE\hekate.bin" (rename %~dp0ASAP-PACKAGE\hekate.bin payload.bin)
mkdir "%~dp0ASAP-PACKAGE\bootloader\ini"
REM create to version and loacations.conf file
mkdir "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\010B6ECF3B30D000\03"
echo %hekate_ver%^|%asap_ver%^|%type% > "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\010B6ECF3B30D000\03\0100B0E8EB470000"
echo ["usb:/","usbfs:/","sdmc:/","sdmc:/roms/","system:/","user:/","safe:/",{"url":"https://tiny.cc/eeveesaveproject","title":"Eevee Save Project","enabled":1},{"url":"https://e.cchi.me/","title":"Ecchi Save Project","enabled":1},{"url":"https://liberashop.rs/roms","title":"LiberaShop Retro ROMs","enabled":1},{"url":"https://liberashop.rs/","title":"LiberaShop","enabled":1},{"url":"https://publictest:publicpass@switch.ghostland.at/","title":"Ghost eShop","enabled":1}] > "%~dp0ASAP-PACKAGE\ASAP\locations.conf"
cd ASAP-PACKAGE
zip -r AIS_normal.zip .\
xcopy "%~dp0ASAP-PACKAGE\AIS_normal.zip" "%~dp0output\AIS\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0ASAP-PACKAGE\AIS_normal.zip" (DEL /F "%~dp0ASAP-PACKAGE\AIS_normal.zip")
if exist "%~dp0ASAP-PACKAGE\ASAP\ASAP-Updater.nro" (DEL /F "%~dp0ASAP-PACKAGE\ASAP\ASAP-Updater.nro")

REM ASAP-normal.test
xcopy "%~dp0ASAP-Updater\change\test\ASAP-Updater_test.nro" "%~dp0ASAP-PACKAGE\ASAP\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0ASAP-PACKAGE\ASAP\ASAP-Updater_test.nro" (rename %~dp0ASAP-PACKAGE\ASAP\ASAP-Updater_test.nro ASAP-Updater.nro)
xcopy "%~dp0patches\sys-patch\out\switch\.overlays\sys-patch-overlay.ovl" "%~dp0ASAP-PACKAGE\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0patches\SPU\out\switch\SPU" "%~dp0ASAP-PACKAGE\ASAP\SPU" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\010B6ECF3B30D000\03\0100B0E8EB470000" (DEL /F "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\010B6ECF3B30D000\03\0100B0E8EB470000")
echo %hekate_ver%^| TESTER ^|%type% > "%~dp0ASAP-PACKAGE\ASAP\atmosphere\contents\010B6ECF3B30D000\03\0100B0E8EB470000"
zip -r AIS_normal.zip .\
xcopy "%~dp0ASAP-PACKAGE\AIS_normal.zip" "%~dp0output\tester\" /H /Y /C /R /S /I >nul 2>nul

REM ASAP-UPDATER
mkdir "%~dp0ASAP-PACKAGE\APP\atmosphere\contents\010B6ECF3B30D000\03"
xcopy "%~dp0SAK\output\nsp\ASAP-Updater_[01B88DD22E0D0000].nsp" "%~dp0ASAP-PACKAGE\APP\nsp\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0ASAP-Updater\.ASAP-Updater.nro.star" "%~dp0ASAP-PACKAGE\APP\switch\ASAP-Updater\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0ASAP-Updater\ASAP-Updater.nro" "%~dp0ASAP-PACKAGE\APP\switch\ASAP-Updater\" /H /Y /C /R /S /I >nul 2>nul
echo %hekate_ver%^|%asap_ver%^| APP > "%~dp0ASAP-PACKAGE\APP\atmosphere\contents\010B6ECF3B30D000\03\0100B0E8EB470000"
cd APP
zip -r app.zip .\
xcopy "%~dp0ASAP-PACKAGE\APP\app.zip" "%~dp0output\archive_aio\" /H /Y /C /R /S /I >nul 2>nul

REM Tester+
xcopy "%~dp0ASAP-Updater\.ASAP-Updater.nro.star" "%~dp0ASAP-PACKAGE\Ultrahand\Tester+\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0ASAP-Updater\change\test\ASAP-Updater_test.nro" "%~dp0ASAP-PACKAGE\Ultrahand\Tester+\" /H /Y /C /R /S /I >nul 2>nul
echo %hekate_ver%^| TESTER ^|%type% > "%~dp0ASAP-PACKAGE\Ultrahand\Tester+\version"
if exist "%~dp0ASAP-PACKAGE\Ultrahand\Tester+\ASAP-Updater_test.nro" (rename %~dp0ASAP-PACKAGE\Ultrahand\Tester+\ASAP-Updater_test.nro ASAP-Updater.nro)
cd ..\Ultrahand\Tester+
zip -r Tester+.zip .\
xcopy "%~dp0ASAP-PACKAGE\Ultrahand\Tester+\Tester+.zip" "%~dp0output\archive_aio\" /H /Y /C /R /S /I >nul 2>nul

REM App+
xcopy "%~dp0programs\overlays\emuiibo\emuiibo\boot2.flag" "%~dp0ASAP-PACKAGE\Ultrahand\App+\atmosphere\contents\0100000000000352\flags\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\emuiibo\exefs.nsp" "%~dp0ASAP-PACKAGE\Ultrahand\App+\atmosphere\contents\0100000000000352\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\emuiibo\toolbox.json" "%~dp0ASAP-PACKAGE\Ultrahand\App+\atmosphere\contents\0100000000000352\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\SaltySD\0000000000534C56" "%~dp0ASAP-PACKAGE\Ultrahand\App+\atmosphere\contents\0000000000534C56" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\MissionControl\dist\MissionControl" "%~dp0ASAP-PACKAGE\Ultrahand\App+\config\ASAP-assist\Controller\MissionControl" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\sys-con\out\atmosphere\contents\690000000000000D" "%~dp0ASAP-PACKAGE\Ultrahand\App+\config\ASAP-assist\Controller\sys-con\690000000000000D" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\sys-con\out\config\sys-con" "%~dp0ASAP-PACKAGE\Ultrahand\App+\config\ASAP-assist\Controller\sys-con\sys-con" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\sys-con\out\switch" "%~dp0ASAP-PACKAGE\Ultrahand\App+\config\ASAP-assist\Controller\sys-con\switch" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\homebrews\JKSV\JKSV.nro" "%~dp0ASAP-PACKAGE\Ultrahand\App+\config\ASAP-assist\Homebrews\JKSV\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\homebrews\Linkalho\linkalho.nro" "%~dp0ASAP-PACKAGE\Ultrahand\App+\config\ASAP-assist\Homebrews\Linkalho\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\overlay\lang" "%~dp0ASAP-PACKAGE\Ultrahand\App+\emuiibo\overlay\lang" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\favorites.txt" "%~dp0ASAP-PACKAGE\Ultrahand\App+\emuiibo\overlay\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\sysmodules\SaltySD\SaltySD" "%~dp0ASAP-PACKAGE\Ultrahand\App+\SaltySD" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\overlays\emuiibo\overlay\emuiibo.ovl" "%~dp0ASAP-PACKAGE\Ultrahand\App+\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\FPSLocker\FPSLocker.ovl" "%~dp0ASAP-PACKAGE\Ultrahand\App+\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\EdiZon-Overlay\out\ovlEdiZon.ovl" "%~dp0ASAP-PACKAGE\Ultrahand\App+\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\ovl-sysmodules\ovlSysmodules.ovl" "%~dp0ASAP-PACKAGE\Ultrahand\App+\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\ReverseNX-RT\Out\switch\.overlays\ReverseNX-RT-ovl.ovl" "%~dp0ASAP-PACKAGE\Ultrahand\App+\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0programs\overlays\Status-Monitor-Overlay\Status-Monitor-Overlay.ovl" "%~dp0ASAP-PACKAGE\Ultrahand\App+\switch\.overlays\" /H /Y /C /R /S /I >nul 2>nul
mkdir "%~dp0ASAP-PACKAGE\Ultrahand\App+\switch\.overlays\.offload"
cd ..\App+
zip -r App+.zip .\
xcopy "%~dp0ASAP-PACKAGE\Ultrahand\App+\App+.zip" "%~dp0output\archive_aio\" /H /Y /C /R /S /I >nul 2>nul

REM Package+
xcopy "%~dp0programs\sys-clk\sys-clk-oc\atmosphere\contents\00FF0000636C6BFF" "%~dp0ASAP-PACKAGE\Ultrahand\Package+\OC" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\overlays\Ultrahand-Overlay\Packages\*" "%~dp0ASAP-PACKAGE\Ultrahand\Package+\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sys-clk\sys-clk-oc\switch\sys-clk-manager" "%~dp0ASAP-PACKAGE\Ultrahand\Package+\sys-clk-manager" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0programs\sys-clk\sys-clk-oc\switch\.overlays\sys-clk-overlay.ovl" "%~dp0ASAP-PACKAGE\Ultrahand\Package+\" /H /Y /C /R /S /I >nul 2>nul
cd ..\Package+
zip -r Package+.zip .\
xcopy "%~dp0ASAP-PACKAGE\Ultrahand\Package+\Package+.zip" "%~dp0output\archive_aio\" /H /Y /C /R /S /I >nul 2>nul

REM Ultrahand
xcopy "%~dp0programs\overlays\Ultrahand-Overlay\ovlmenu.ovl" "%~dp0output\archive_aio\" /H /Y /C /R /S /I >nul 2>nul

REM ASAP-PACKAGING DELETE
cd ..\..\..\
if exist "%~dp0ASAP-PACKAGE" (RD /S /Q "%~dp0ASAP-PACKAGE")

GOTO TITLE

REM ============================================================
:HATS

cls
cd migrate\HATS\
unzip *.zip
cd ..\..\

REM HATS
REM ASAP folder
xcopy "%~dp0migrate\HATS\atmosphere" "%~dp0ASAP-PACKAGE\HATS\ASAP\atmosphere" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\atmosphere\contents\420000000000000B" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\atmosphere\contents\420000000000000B" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\atmosphere\exefs_patches" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\atmosphere\exefs_patches" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\atmosphere\kip_patches" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\atmosphere\kip_patches" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\bootloader" "%~dp0ASAP-PACKAGE\HATS\ASAP\bootloader" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\bootloader\patches.ini" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\bootloader\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\HATS\config" "%~dp0ASAP-PACKAGE\HATS\ASAP\config" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0SAK\output\nsp\hbmenu_[01E2044444AB9000][v1].nsp" "%~dp0ASAP-PACKAGE\HATS\ASAP\nsp\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\scripts" "%~dp0ASAP-PACKAGE\HATS\ASAP\scripts" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\switch" "%~dp0ASAP-PACKAGE\HATS\ASAP\switch" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\HATS\boot.dat" "%~dp0ASAP-PACKAGE\HATS\ASAP\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\HATS\boot.ini" "%~dp0ASAP-PACKAGE\HATS\ASAP\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0migrate\HATS\atmosphere" (RD /S /Q "%~dp0migrate\HATS\atmosphere")
if exist "%~dp0migrate\HATS\bootloader" (RD /S /Q "%~dp0migrate\HATS\bootloader")
if exist "%~dp0migrate\HATS\config" (RD /S /Q "%~dp0migrate\HATS\config")
if exist "%~dp0migrate\HATS\scripts" (RD /S /Q "%~dp0migrate\HATS\scripts")
if exist "%~dp0migrate\HATS\switch" (RD /S /Q "%~dp0migrate\HATS\switch")
if exist "%~dp0migrate\HATS\boot.dat" (DEL /F "%~dp0migrate\HATS\boot.dat")
if exist "%~dp0migrate\HATS\boot.ini" (DEL /F "%~dp0migrate\HATS\boot.ini")
REM atmosphere folder
xcopy "%~dp0ATLAS\output\atmosphere\contents\010B6ECF3B30D000\01\420E00000311EM04" "%~dp0ASAP-PACKAGE\HATS\atmosphere\contents\010B6ECF3B30D000\01\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\migrate.te" "%~dp0ASAP-PACKAGE\HATS\atmosphere\contents\010B6ECF3B30D000\01\" /H /Y /C /R /S /I >nul 2>nul
REM bootloader folder
xcopy "%~dp0ASAP-Updater\ATLAS\output\ATLAS.bin" "%~dp0ASAP-PACKAGE\HATS\bootloader\payloads\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0ATLAS\output\bootloader\sys\module" "%~dp0ASAP-PACKAGE\HATS\bootloader\sys\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hekate\CTCaer\hekate_ipl.ini" "%~dp0ASAP-PACKAGE\HATS\bootloader\" /H /Y /C /R /S /I >nul 2>nul
REM sx_gear files
xcopy "%~dp0migrate\HATS\exosphere.ini" "%~dp0ASAP-PACKAGE\HATS\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\HATS\hbmenu.nro" "%~dp0ASAP-PACKAGE\HATS\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\HATS\payload.bin" "%~dp0ASAP-PACKAGE\HATS\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0migrate\HATS\exosphere.ini" (DEL /F "%~dp0migrate\HATS\exosphere.ini")
if exist "%~dp0migrate\HATS\hbmenu.nro" (DEL /F "%~dp0migrate\HATS\hbmenu.nro")
if exist "%~dp0migrate\HATS\payload.bin" (DEL /F "%~dp0migrate\HATS\payload.bin")
REM create folder, rename file
if exist "%~dp0ASAP-PACKAGE\HATS\atmosphere\contents\010B6ECF3B30D000\01\migrate.te" (rename %~dp0ASAP-PACKAGE\HATS\atmosphere\contents\010B6ECF3B30D000\01\migrate.te 01001FF3CDEC5000)

cd ASAP-PACKAGE\HATS
zip -r HATS.zip .\
cd ..\..\
xcopy "%~dp0ASAP-PACKAGE\HATS\HATS.zip" "%~dp0output\ASAP-Updater\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0ASAP-PACKAGE" (RD /S /Q "%~dp0ASAP-PACKAGE")

GOTO ENDPG0

REM ============================================================
:KEFIR

cls
cd migrate\KEFIR\
unzip *.zip
cd ..\..\

REM KEFIR
REM ASAP folder
xcopy "%~dp0migrate\Kefir\atmosphere" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\atmosphere" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\bootloader" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\bootloader" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\updating.bmp" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\bootloader\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\config" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\config" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0SAK\output\nsp\hbmenu_[01E2044444AB9000][v1].nsp" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\games\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\switch" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\switch" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\boot.dat" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\boot.ini" "%~dp0ASAP-PACKAGE\KEFIR\ASAP\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0ASAP-PACKAGE\KEFIR\ASAP\atmosphere\kip_patches\kip_patches" (RD /S /Q "%~dp0ASAP-PACKAGE\KEFIR\ASAP\atmosphere\kip_patches\kip_patches")
if exist "%~dp0ASAP-PACKAGE\KEFIR\ASAP\bootloader\sys\module_sample.bso" (DEL /F "%~dp0ASAP-PACKAGE\KEFIR\ASAP\bootloader\sys\module_sample.bso")
if exist "%~dp0migrate\Kefir\boot.dat" (DEL /F "%~dp0migrate\KEFIR\boot.dat")
if exist "%~dp0migrate\Kefir\boot.ini" (DEL /F "%~dp0migrate\KEFIR\boot.ini")
if exist "%~dp0migrate\Kefir\atmosphere" (RD /S /Q "%~dp0migrate\KEFIR\atmosphere")
if exist "%~dp0migrate\Kefir\bootloader" (RD /S /Q "%~dp0migrate\KEFIR\bootloader")
if exist "%~dp0migrate\Kefir\config" (RD /S /Q "%~dp0migrate\KEFIR\config")
if exist "%~dp0migrate\Kefir\games" (RD /S /Q "%~dp0migrate\KEFIR\games")
if exist "%~dp0migrate\Kefir\oc" (RD /S /Q "%~dp0migrate\KEFIR\oc")
if exist "%~dp0migrate\Kefir\switch" (RD /S /Q "%~dp0migrate\KEFIR\switch")
REM atmosphere folder
xcopy "%~dp0ATLAS\output\atmosphere\contents\010B6ECF3B30D000\01\420E00000311EM04" "%~dp0ASAP-PACKAGE\KEFIR\atmosphere\contents\010B6ECF3B30D000\01\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\migrate.te" "%~dp0ASAP-PACKAGE\KEFIR\atmosphere\contents\010B6ECF3B30D000\01\" /H /Y /C /R /S /I >nul 2>nul
REM bootloader folder
xcopy "%~dp0ASAP-Updater\ATLAS\output\ATLAS.bin" "%~dp0ASAP-PACKAGE\KEFIR\bootloader\payloads\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0ATLAS\output\bootloader\sys\module" "%~dp0ASAP-PACKAGE\KEFIR\bootloader\sys\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hekate\CTCaer\hekate_ipl.ini" "%~dp0ASAP-PACKAGE\KEFIR\bootloader\" /H /Y /C /R /S /I >nul 2>nul
REM sx_gear files
xcopy "%~dp0migrate\Kefir\exosphere.ini" "%~dp0ASAP-PACKAGE\KEFIR\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\hbmenu.nro" "%~dp0ASAP-PACKAGE\KEFIR\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\Kefir\payload.bin" "%~dp0ASAP-PACKAGE\KEFIR\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0migrate\Kefir\exosphere.ini" (DEL /F "%~dp0migrate\KEFIR\exosphere.ini")
if exist "%~dp0migrate\Kefir\hbmenu.nro" (DEL /F "%~dp0migrate\KEFIR\hbmenu.nro")
if exist "%~dp0migrate\Kefir\install.bat" (DEL /F "%~dp0migrate\KEFIR\install.bat")
if exist "%~dp0migrate\Kefir\payload.bin" (DEL /F "%~dp0migrate\KEFIR\payload.bin")
REM create folder, rename file
if exist "%~dp0ASAP-PACKAGE\KEFIR\atmosphere\contents\010B6ECF3B30D000\01\migrate.te" (rename %~dp0ASAP-PACKAGE\KEFIR\atmosphere\contents\010B6ECF3B30D000\01\migrate.te 01001FF3CDEC5000)

cd ASAP-PACKAGE\KEFIR
zip -r KEFIR.zip .\
cd ..\..\
xcopy "%~dp0ASAP-PACKAGE\KEFIR\KEFIR.zip" "%~dp0output\ASAP-Updater\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0ASAP-PACKAGE" (RD /S /Q "%~dp0ASAP-PACKAGE")

GOTO ENDPG0

REM ============================================================
:DEEPSEA

cd migrate\DEEPSEA\
unzip *.zip
cd ..\..\

cls
REM DEEPSEA
REM ASAP folder
xcopy "%~dp0migrate\DEEPSEA\atmosphere" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\atmosphere" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\DEEPSEA\bootloader" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\bootloader" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\DEEPSEA\config" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\config" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\DEEPSEA\emuiibo" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\emuiibo" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0SAK\output\nsp\hbmenu_[01E2044444AB9000][v1].nsp" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\nsp\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0migrate\DEEPSEA\switch" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\switch" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%~dp0settings\boot.dat" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0settings\boot.ini" "%~dp0ASAP-PACKAGE\DEEPSEA\ASAP\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0migrate\DEEPSEA\atmosphere" (RD /S /Q "%~dp0migrate\DEEPSEA\atmosphere")
if exist "%~dp0migrate\DEEPSEA\bootloader" (RD /S /Q "%~dp0migrate\DEEPSEA\bootloader")
if exist "%~dp0migrate\DEEPSEA\config" (RD /S /Q "%~dp0migrate\DEEPSEA\config")
if exist "%~dp0migrate\DEEPSEA\emuiibo" (RD /S /Q "%~dp0migrate\DEEPSEA\emuiibo")
if exist "%~dp0migrate\DEEPSEA\switch" (RD /S /Q "%~dp0migrate\DEEPSEA\switch")
REM atmosphere folder
xcopy "%~dp0ATLAS\output\atmosphere\contents\010B6ECF3B30D000\01\420E00000311EM04" "%~dp0ASAP-PACKAGE\DEEPSEA\atmosphere\contents\010B6ECF3B30D000\01\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\migrate.te" "%~dp0ASAP-PACKAGE\DEEPSEA\atmosphere\contents\010B6ECF3B30D000\01\" /H /Y /C /R /S /I >nul 2>nul
REM bootloader folder
xcopy "%~dp0ASAP-Updater\ATLAS\output\ATLAS.bin" "%~dp0ASAP-PACKAGE\DEEPSEA\bootloader\payloads\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0ATLAS\output\bootloader\sys\module" "%~dp0ASAP-PACKAGE\DEEPSEA\bootloader\sys\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0hekate\CTCaer\hekate_ipl.ini" "%~dp0ASAP-PACKAGE\DEEPSEA\bootloader\" /H /Y /C /R /S /I >nul 2>nul
REM sx_gear files
xcopy "%~dp0migrate\DEEPSEA\hbmenu.nro" "%~dp0ASAP-PACKAGE\DEEPSEA\" /H /Y /C /R /S /I >nul 2>nul
xcopy "%~dp0migrate\DEEPSEA\hekate*.bin" "%~dp0ASAP-PACKAGE\DEEPSEA\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0migrate\DEEPSEA\hbmenu.nro" (DEL /F "%~dp0migrate\DEEPSEA\hbmenu.nro")
if exist "%~dp0migrate\DEEPSEA\hekate*.bin" (DEL /F "%~dp0migrate\DEEPSEA\hekate*.bin")
echo [exosphere] > "%~dp0ASAP-PACKAGE\DEEPSEA\exosphere.ini"
echo blank_prodinfo_sysmmc=0 >> "%~dp0ASAP-PACKAGE\DEEPSEA\exosphere.ini"
echo blank_prodinfo_emummc=1 >> "%~dp0ASAP-PACKAGE\DEEPSEA\exosphere.ini"
REM create folder, rename file
if exist "%~dp0ASAP-PACKAGE\DEEPSEA\atmosphere\contents\010B6ECF3B30D000\01\migrate.te" (rename %~dp0ASAP-PACKAGE\DEEPSEA\atmosphere\contents\010B6ECF3B30D000\01\migrate.te 01001FF3CDEC5000)
if exist "%~dp0ASAP-PACKAGE\DEEPSEA\hekate*.bin" (rename %~dp0ASAP-PACKAGE\DEEPSEA\hekate*.bin payload.bin)

cd ASAP-PACKAGE\DEEPSEA
zip -r DEEPSEA.zip .\
cd ..\..\
xcopy "%~dp0ASAP-PACKAGE\DEEPSEA\DEEPSEA.zip" "%~dp0output\ASAP-Updater\" /H /Y /C /R /S /I >nul 2>nul
if exist "%~dp0ASAP-PACKAGE" (RD /S /Q "%~dp0ASAP-PACKAGE")

GOTO ENDPG0

REM ============================================================
:HEKATEUSB
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                                   - Hekate USB Max Rate -
echo.                             
echo.
echo                                Run only once pre windows PC
echo.
echo =====================================================================================================
echo.
echo      1 = Registry adjustments
echo.
echo      2 = Skip
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      B = Back
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set /p HEKATEUSB=     - Please enter the command: 
	if "%HEKATEUSB%"=="1" GOTO USB3
	if "%HEKATEUSB%"=="2" GOTO ATFIXDEL
	if /i "%HEKATEUSB%"=="B" GOTO TITLE
pause>nul 2>&1

:USB3
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f>nul 2>&1
GOTO ATFIXDEL

REM ============================================================	
:ATFIXDEL
COLOR 0A
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                                           - Completed -  
echo.
echo                        Modify the archive bit and turn off the attribute
echo.
echo =====================================================================================================

if exist "%sd%:\ASAP" (
	attrib -A -R /S /D %sd%:\ASAP\*
	attrib -A -R %sd%:\ASAP)
if exist "%sd%:\atmosphere" (
	attrib -A -R /S /D %sd%:\atmosphere\*
	attrib -A -R %sd%:\atmosphere)
if exist "%sd%:\backup" (
	attrib -A -R /S /D %sd%:\backup\*
	attrib -A -R %sd%:\backup)
if exist "%sd%:\bootloader" (
	attrib -A -R /S /D %sd%:\bootloader\*
	attrib -A -R %sd%:\bootloader)
if exist "%sd%:\config" (
	attrib -A -R /S /D %sd%:\config\*
	attrib -A -R %sd%:\config)
if exist "%sd%:\emuiibo" (
	attrib -A -R /S /D %sd%:\emuiibo\*
	attrib -A -R %sd%:\emuiibo)
if exist "%sd%:\nsp" (
	attrib -A -R /S /D %sd%:\nsp\*
	attrib -A -R %sd%:\nsp)
if exist "%sd%:\SaltySD" (
	attrib -A -R /S /D %sd%:\SaltySD\*
	attrib -A -R %sd%:\SaltySD)
if exist "%sd%:\switch" (
	attrib -A -R /S /D %sd%:\switch\*
	attrib -A -R %sd%:\switch)
if exist "%sd%:\warmboot_mariko" (
	attrib -A -R /S /D %sd%:\warmboot_mariko\*
	attrib -A -R %sd%:\warmboot_mariko)
if exist "%sd%:\boot.dat" (attrib -A -R %sd%:\boot.dat)
if exist "%sd%:\boot.ini" (attrib -A -R %sd%:\boot.ini)
if exist "%sd%:\payload.bin" (attrib -A -R %sd%:\payload.bin)
if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*
powershell -Command "Start-Sleep -Seconds 2"

:ATFIXDEL1
echo.
echo                                    Please wait for a moment...
echo.
echo -----------------------------------------------------------------------------------------------------
powershell -Command "Start-Sleep -Seconds 2"

GOTO ENDPG

REM ============================================================
:NOTMATCHDRIVE
COLOR 0C
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                                            - Warning - 
echo.
echo                   [ %sd%:/ ] drive selected is missing or disconnected
echo.
echo.
echo =====================================================================================================
echo.
echo      1.  Selected drive is correct^^!
echo.
echo      2.  Select again
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      3.  Quit
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set /p st=     - Please enter the command: 

for %%A in ("Y" "y" "1") do if "%st%"==%%A (GOTO BACKUP)
for %%A in ("N" "n" "2") do if "%st%"==%%A (GOTO NOTICE)
for %%A in ("B" "b" "3") do if "%st%"==%%A (GOTO ENDPG)

REM ============================================================
:ENDPG
COLOR 0A
echo.
echo                                      - Process termination - 
echo.
echo                                     Safely exits the program^^! 
echo.
echo =====================================================================================================
echo.

if exist "%wd%" (RD /s /q "%wd%\*") >nul 2>nul
powershell -Command "Start-Sleep -Seconds 3"
exit

REM ============================================================
:ENDPG0
COLOR 09
echo.
echo.
echo =====================================================================================================
echo.
echo                                      - Packaging completed - 
echo.
echo                                     Safely exits the program^^! 
echo.
echo =====================================================================================================
echo.

if exist "%wd%" (RD /s /q "%wd%\*") >nul 2>nul
powershell -Command "Start-Sleep -Seconds 3"
exit
