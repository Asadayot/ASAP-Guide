# archive_aio
  - **AIS**: ASAP Install Supporter
  - **[ASAP-Updater](https://github.com/HamletDuFromage/aio-switch-updater)**: *Origin, Test, Share*
  - **ATLAS**: *AIS, [TegraExplorer](https://github.com/suchmememanyskill/TegraExplorer)/Toolboxes, L, ASAP-Cleaner, Scripts*
  - **[atmo_logo_creator](https://github.com/Yorunokyujitsu/archive_aio)**: *atmo fatal/first splash iamge creator/extractor*
  - **[Atmosphere](https://github.com/Atmosphere-NX/Atmosphere)**: *patch/over version*
  - **hb**: *[nx-hbmenu](https://github.com/switchbrew/nx-hbmenu), [nx-hbloader](https://github.com/switchbrew/nx-hbloader)*
  - **[hekate](https://github.com/CTCaer/hekate)**: *Korean*
  - **[libnx](https://github.com/switchbrew/libnx)**: *4.7.0*
  - **migarte**: *[DeepSea](https://github.com/Team-Neptune/DeepSea), [HATS](https://www.sthetix.info), [Kefir](https://github.com/rashevskyv/kefir)*
  - **patches**: *locked - sys-patch, sigpatch-updater*
  - **programs**: *Hombrews, Overlays, sysmodule*
  - **[SAK](https://github.com/dezem/SAK)**: *switch army knife*
  - **build.sh**: *Make script*
  - **pack.sh**: *Packaging script*
  - **ASAP.bat**: *SD install, make/packaging batch*

## All Source Code Download
- Run **AIS-Tester Only version** *(ASAP.exe)* > Click on **`Source Code`**
- Git clone **ASAP archive** > Unzip some zip files using password

## How to build & packaging
1. Install **[python](https://www.python.org/downloads/)** and **[MSYS2](https://github.com/msys2/msys2-installer/releases)** in **`./msys64/`**.
2. Place the **`prod.keys`** file in **`./msys64/home/user_name/.switch/`**.
3. Add line to **`./msys64/etc/pacman.conf`** file.
```
[dkp-libs]
Server = https://pkg.devkitpro.org/packages

[dkp-windows]
Server = https://pkg.devkitpro.org/packages/windows/$arch/
```
4. Run **mingw64.exe** > Signing the DevKitPro cypher keys.
```
pacman-key --recv BC26F752D25B92CE272E0F44F7FD5492264BB9D0 --keyserver keyserver.ubuntu.com
pacman-key --lsign BC26F752D25B92CE272E0F44F7FD5492264BB9D0
pacman-key -l BC26F752D25B92CE272E0F44F7FD5492264BB9D0
pacman-key -l F7FD5492264BB9D0
pacman -Syuu --needed --noconfirm
pacman -U --needed --noconfirm https://pkg.devkitpro.org/devkitpro-keyring.pkg.tar.xz
```
5. Install DevkitPro packages.
```
pacman -Syuu --needed --noconfirm git gcc make curl zip lz4 devkitA64 devkitARM dkp-toolchain-vars hactool python-pip python-setuptools mingw-w64-x86_64-gcc mingw-w64-x86_64-python-pip mingw-w64-x86_64-python-pycryptodome mingw-w64-x86_64-python-lz4 switch-dev switch-sdl2_image switch-sdl2_gfx switch-glad switch-glfw switch-glm switch-freetype switch-libconfig switch-libjson-c switch-physfs switch-curl switch-zziplib switch-mbedtls switch-jansson switch-tinyxml2
```
6. Install python libraries.
```
pip install py lz4 pycryptodome
```
7. Run until the `there is nothing to do` appears.
```
pacman -Syuu --needed --noconfirm
```
8. Place the sys-patch in **`patches/`** path.
9. Edit source codes.
10. Download **[zip.exe](http://stahlworks.com/dev/zip.exe)**, **[unzip.exe](http://stahlworks.com/dev/unzip.exe)** and move to **`windows/system32/`** path.
11. Place the image files in the **`atmo_logo_creator/resources/`** with names **`splash`** or **`fatal`** or both.
12. Run **`ASAP.bat`** > input commands **`AIS`** > **`LOGO`** > **`MAKE`** > When finished, **`PACK`**.

## Change splash logo
- Change the logo, not the splash screen.
- Place the splash image files in the **`Atmosphere/img/`** with names **`splash.png`**.
- This will create **`Atmosphere/img/splash.bin`** and building atmosphere will change the splash logo.
- There is no need to use the **`SPLASH`** command again unless you change the splash logo to a different image in future builds.

9. Run **`ASAP.bat`** > input **`AIS`** > **`LOGO`** > **`MAKE`** > **`SPLASH`** > **`PACK`**.

## If Build on Linux (Ubuntu)
1. Git clone **ASAP archive** > Unzip some zip files using password.
2. Install utilities & python libraries.
```
sudo apt install lz4 zip git make gcc python3 python-is-python3 python3-pip
sudo pip install py pillow pycryptodome lz4 numpy

# if using ubuntu 22.04 ~
sudo apt update
sudo apt install lz4 zip git make gcc python3 python-is-python3 python3-py python3-pip python3-pil python3-pycryptodome python3-lz4 python3-numpy
```
3. Install devkitpro
```
wget https://apt.devkitpro.org/install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman
```
4. Install devkitpro-pacman packages.
```
chmod 755 /opt/
sudo dkp-pacman -Syuu --needed --noconfirm switch-dev devkitARM devkitarm-rules hactool dkp-toolchain-vars switch-curl switch-freetype switch-glad switch-glfw switch-glm switch-jansson switch-libconfig switch-libdrm_nouveau switch-libjpeg-turbo switch-libjson-c switch-libpng switch-libwebp switch-mbedtls switch-mesa switch-physfs switch-sdl2 switch-sdl2_gfx switch-sdl2_image switch-tinyxml2 switch-zlib switch-zziplib
```
5. Setting environment variables for devkitpro.
```
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC
```
6. Create splash & fatal logos.
```
cd atmo_logo_creator
python ./scripts/create_logos.py
```
7. Place the sys-patch in **`patches/`** path.
8. Build all repositories.
```
chmod +x build.sh
./build.sh
```
9. Packaging ASAP.
```
chmod +x pack.sh
./pack.sh
```

## Finish
- **`PACK`** Command > **`output/*`** folders & files.
- **`ASAP`** Command > Unzip **`output/AIS/AIS_normal.zip`** file.
- Move to SD card > Insert into Nintendo Switch and turn on power.

## Credits
- **[MSYS2](https://www.msys2.org/)** : [MSYS2](https://github.com/msys2/msys2-installer) ┃ **Python** : [Python](https://www.python.org) ┃ **[stahlworks](http://stahlworks.com/)** : [zip.exe](http://stahlworks.com/dev/zip.exe), [unzip.exe](http://stahlworks.com/dev/unzip.exe) ┃ **[dezem](https://github.com/dezem)** : [SAK](https://github.com/dezem/SAK) <br>
- **[switchbrew](https://github.com/switchbrew)** : [libnx](https://github.com/switchbrew/libnx), [nx-hbloader](https://github.com/switchbrew/nx-hbloader), [nx-hbmenu](https://github.com/switchbrew/nx-hbmenu) ┃ **Patches** : [ITotalJustice](https://github.com/ITotalJustice), [mrdude2478](https://github.com/mrdude2478) <br>

- **[Asa](https://github.com/Asadayot)** : AIS(ASAP Install Supporter), [atmo_logo_creator](https://github.com/Yorunokyujitsu/atmo_logo_creator)<br>
**[CTCaer](https://github.com/CTCaer)** : [Hekate & Nyx](https://github.com/CTCaer/hekate) ┃ **[Atmosphère-NX](https://github.com/Atmosphere-NX)** : [libnx](https://github.com/Atmosphere-NX/libnx), [Atmosphère, Haze, Daybreak, Reboot to payload](https://github.com/Atmosphere-NX/Atmosphere) <br>

- **[shchmue](https://github.com/shchmue)** : **Lockpick RCM** ┃ **[suchmememanyskill](https://github.com/suchmememanyskill)** : **[TegraExplorer](https://github.com/suchmememanyskill/TegraExplorer)** <br>

- **[HamletDuFromage](https://github.com/HamletDuFromage)** : [aio-switch-updater](https://github.com/HamletDuFromage/aio-switch-updater) ┃ **[J-D-K](https://github.com/J-D-K)** : [JKSV](https://github.com/J-D-K/JKSV) ┃ **[rdmrocha](https://github.com/rdmrocha)** : [Linkalho](https://github.com/rdmrocha/linkalho) ┃ **[Tinfoil](https://tinfoil.io/)** : [Tinfoil](https://tinfoil.io/)

- **[retronx-team](https://github.com/retronx-team)** : [sys-clk, sys-clk-manager](https://github.com/retronx-team/sys-clk) ┃ **[B3711](https://discord.gg/KJQdJnKWqa)** : [sys-clk-oc](https://discord.gg/KJQdJnKWqa) ┃ **[halop](https://github.com/halop)** : [OC Toolkit SC, OC Toolkit EOS](https://github.com/halop/OC_Toolkit) <br>
**[WerWolv](https://github.com/WerWolv)** : [nx-ovlloader](https://github.com/WerWolv/nx-ovlloader), [ovl-sysmodules](https://github.com/WerWolv/ovl-sysmodules) ┃ **[ppkantorski](https://github.com/ppkantorski)** : [Ultrahand-Overlay](https://github.com/ppkantorski/Ultrahand-Overlay) ┃ **[proferabg](https://github.com/proferabg)** : [EdiZon-Overlay](https://github.com/proferabg/EdiZon-Overlay) <br>
**[XorTroll](https://github.com/XorTroll)** : [emuiibo](https://github.com/XorTroll/emuiibo) ┃ **[masagrator](https://github.com/masagrator)** : [SaltyNX](https://github.com/masagrator/SaltyNX), [FPSLocker](https://github.com/masagrator/FPSLocker), [ReverseNX-RT](https://github.com/masagrator/ReverseNX-RT), [Status-Monitor-Overlay](https://github.com/masagrator/Status-Monitor-Overlay) <br>

- **[ndeadly](https://github.com/ndeadly)** : [MissionControl](https://github.com/ndeadly/MissionControl) ┃ **[cathery](https://github.com/cathery)** : [sys-con](https://github.com/cathery/sys-con) <br>

- **[Team-Neptune](https://github.com/Team-Neptune)** : [DeepSea](https://github.com/Team-Neptune/DeepSea) ┃ **[rashevskyv](https://github.com/rashevskyv)** : [Kefir](https://github.com/rashevskyv/kefir), [DBI](https://github.com/rashevskyv/dbi), [Kefirosphere](https://github.com/rashevskyv/Kefirosphere) ┃ **[sthetix](https://www.sthetix.info)** : [HATS, INSTINCT-Toolbox](https://filedn.com/lric62b9t2vz5v4OvwHkKJS/HATS) <br>

- **TEAM-XECUTER** : SX Gear ┃ **[Spacecraft-NX](https://github.com/Spacecraft-NX)** : [Spacecraft](https://github.com/Spacecraft-NX/firmware) ┃ **[Hwfly-nx](https://github.com/hwfly-nx)** : [Hwfly](https://github.com/hwfly-nx/firmware), [Hwfly-Toolbox](https://github.com/hwfly-nx/hwfly-toolbox) <br>
**[INSTINCT-NX](https://drive.google.com/drive/folders/16A9lhFMS_zuNKO6AZEB2QH8XLo7skx86)** : [INSTINCT](https://drive.google.com/drive/folders/16A9lhFMS_zuNKO6AZEB2QH8XLo7skx86) ┃ **[rehius](https://github.com/rehius)** : [Picofly](https://github.com/rehius/usk), [Picofly-Toolbox](https://gbatemp.net/threads/picofly-a-hwfly-switch-modchip.622701/page-78#post-10090767)
