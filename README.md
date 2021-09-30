# Arma 3 Dedicated Server Updater Batch Script
A relatively simple batch script that automatically installs/updates/verifies the latest Arma 3 server, and selected mods (including symbolic link creation for easy start parameters, and key copying to the \keys\ folder), using SteamCMD.

Script ***must*** be edited before its first run to specify the SteamCMD path, server install path, Steam username (must be valid, but does not need to own Arma 3; "annonymous" cannot be used), and mods to download (if desired) using the easy to edit settings at the top of the file.

*(A more advanced PowerShell version of this script that will actually check if mods are already up to date or not is currently in development...)*
