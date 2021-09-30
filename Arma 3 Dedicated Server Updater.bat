@echo off
rem // Arma 3 Dedicated Server/Mod Updater
rem // David Wolfe (Red-Thirten)
rem // Ver 2.1 - 09/30/21
rem // MIT License (Free to copy/modify/distribute for free as long as author is credited)
rem // Automatically installs/updates/verifies latest Arma 3 server, and selected mods (including symbolic link creation for easy start parameters, and key copying to the keys folder), using SteamCMD.
rem // Refer to remark statements below for customization.

rem // Updater Title (Cosmetic. Change as needed)
title Arma 3 Dedicated Server Updater

rem // PATHS (Change as needed)
rem // SteamCMD Directory (also where mods will be stored)
SET STEAMCMD="C:\Servers\SteamCMD"
rem // Server Directory (where server files will be stored)
SET SRVPATH="C:\Servers\Arma 3 Servers\MyArmaServer"
rem // Steam Username (may require password on first run of batch script)
SET STEAMUSERNAME="USERNAME_REQUIRED_HERE"
rem // Extra SteamCMD Flags (For example, profiling branch would be: -beta profiling -betapassword CautionSpecialProfilingAndTestingBranchArma3)
SET STEAMCMDEXTRAFLAGS=

rem // MODS (All on one line. Change as needed. Format: [Steam Workshop mod ID number][space][Steam Workshop mod ID number][etc])
SET MODLIST=450814997 463939057

rem // =========================================================
rem // BATCH SCRIPT START -- NO NEED TO MODIFY ANYTHING BELOW
rem // =========================================================

SET "LISTLENGTH = 0"

cls
echo.
echo =================================================
echo Arma 3 Dedicated Server/Mod Installer/Updater
echo by David Wolfe (Red-Thirten)
echo =================================================
echo.
echo Make sure your Arma server is off, and your directory locations / mods are
echo set properly in this batch file (using an editor) BEFORE continuing!!!
echo.
pause

echo.
echo =================================================
echo Updating/Validating Arma 3 Dedicated Server...
echo =================================================
echo.

rem // Install/Update/Validate Server
%STEAMCMD%\steamcmd.exe +login %STEAMUSERNAME% +force_install_dir %SRVPATH% +app_update 233780 %STEAMCMDEXTRAFLAGS% validate +quit

rem // Install/Update Mods
for %%l in (%MODLIST%) do set /a "LISTLENGTH+=1"
echo.
echo =================================================
echo Downloading/Updating %LISTLENGTH% mods...
echo =================================================
echo.
timeout /t 3 > nul
for %%m in (%MODLIST%) do ( 	
	echo.
	echo =================================================
	echo Updating mod ID: %%m
	echo =================================================
	echo.
	%STEAMCMD%\steamcmd.exe +login %STEAMUSERNAME% +workshop_download_item 107410 %%m +quit
	echo.
	echo.
	if not exist @%%m\ (
		echo Attempting to make a symobolic link from the server directory to the mod directory...
		mklink /J %SRVPATH%\@%%m %STEAMCMD%\steamapps\workshop\content\107410\%%m
	)
	echo.
	echo Moving any mod .bikeys to the \keys directory...
	for /r %STEAMCMD%\steamapps\workshop\content\107410\%%m %%f in (*.bikey) do copy "%%f" %SRVPATH%\keys
	echo.
)

echo.
echo.
echo.
echo.
echo.
echo.
echo =================================================
echo Server Install/Update Attempt Completed
echo =================================================
echo.
echo.
echo.
echo.
echo.
echo.
pause