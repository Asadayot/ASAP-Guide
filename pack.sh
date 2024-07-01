#!/bin/bash

# Define source and destination directories
src_dir=$(dirname "$0")
dist_dir="$src_dir/output/direct/"

# Define cp_folder equivalent function for copying files
cp_folder() {
    local source="$1"
    local destination="$2"
    mkdir -p "$destination"
    cp -r "$source"/* "$destination"
}

cp_file() {
    local source="$1"
    local destination="$2"
    mkdir -p "$destination"
    cp -r "$source" "$destination"
}

# ASAP folder copies
cp_folder "$src_dir/programs/overlays/Ultrahand-Overlay/Packages" "$dist_dir/ASAP/ASAP-assist"
cp_folder "$src_dir/programs/sysmodules/MissionControl/dist/MissionControl" "$dist_dir/ASAP/ASAP-assist/Controller/MissionControl"
cp_folder "$src_dir/programs/sysmodules/sys-con/out/atmosphere/contents/690000000000000D" "$dist_dir/ASAP/ASAP-assist/Controller/sys-con/690000000000000D"
cp_folder "$src_dir/programs/sysmodules/sys-con/out/config/sys-con" "$dist_dir/ASAP/ASAP-assist/Controller/sys-con/sys-con"
cp_folder "$src_dir/programs/sysmodules/sys-con/out/switch" "$dist_dir/ASAP/ASAP-assist/Controller/sys-con/switch"
cp_file "$src_dir/programs/homebrews/JKSV/JKSV.nro" "$dist_dir/ASAP/ASAP-assist/Homebrews/JKSV"
cp_file "$src_dir/programs/homebrews/Linkalho/linkalho.nro" "$dist_dir/ASAP/ASAP-assist/Homebrews/Linkalho"
cp_file "$src_dir/Atmosphere/config_templates/cloader/eosloader/loader.kip" "$dist_dir/backup/kips/.EOS/"
cp_file "$src_dir/Atmosphere/config_templates/cloader/scloader/loader.kip" "$dist_dir/backup/kips/.SC/"
# cp_folder "$src_dir/programs/sys-clk/sys-clk/dist/atmosphere" "$dist_dir/ASAP/atmosphere"
# cp_folder "$src_dir/programs/sys-clk/sys-clk/dist/switch" "$dist_dir/switch"
cp_folder "$src_dir/programs/sys-clk/sys-clk-oc/atmosphere" "$dist_dir/ASAP/atmosphere"
cp_folder "$src_dir/programs/sys-clk/sys-clk-oc/switch" "$dist_dir/switch"
cp_folder "$src_dir/programs/sys-clk/sys-clk-oc/switch/.overlays" "$dist_dir/switch/.overlays"
cp_folder "$src_dir/Atmosphere/out/nintendo_nx_arm64_armv8a/release/atmosphere-out/atmosphere" "$dist_dir/ASAP/atmosphere"
cp_folder "$src_dir/ATLAS/output/atmosphere" "$dist_dir/ASAP/atmosphere"
cp_file "$src_dir/programs/patches/sys-patch/out/atmosphere/contents/420000000000000B/flags/boot2.flag" "$dist_dir/ASAP/atmosphere/contents/010B6ECF3B30D000/02"
cp_file "$src_dir/programs/patches/sys-patch/out/atmosphere/contents/420000000000000B/exefs.nsp" "$dist_dir/ASAP/atmosphere/contents/010B6ECF3B30D000/02"
cp_file "$src_dir/version" "$dist_dir/ASAP/atmosphere/contents/010B6ECF3B30D000/03"
cp_folder "$src_dir/programs/sysmodules/SaltySD/0000000000534C56" "$dist_dir/ASAP/atmosphere/contents/0000000000534C56"
cp_folder "$src_dir/programs/overlays/420000000007E51A" "$dist_dir/ASAP/atmosphere/contents/420000000007E51A"
cp_file "$src_dir/programs/overlays/emuiibo/emuiibo/boot2.flag" "$dist_dir/ASAP/atmosphere/contents/0100000000000352/flags/"
cp_file "$src_dir/programs/overlays/emuiibo/emuiibo/exefs.nsp" "$dist_dir/ASAP/atmosphere/contents/0100000000000352"
cp_file "$src_dir/programs/overlays/emuiibo/emuiibo/toolbox.json" "$dist_dir/ASAP/atmosphere/contents/0100000000000352"
cp_file "$src_dir/hb/hbmenu/hbmenu.nro" "$dist_dir/ASAP/atmosphere/hb"
cp_file "$src_dir/hb/nx-hbloader/hbl.nsp" "$dist_dir/ASAP/atmosphere/hb"
cp_folder "$src_dir/programs/overlays/emuiibo/overlay/lang" "$dist_dir/ASAP/emuiibo/overlay/lang"
cp_file "$src_dir/programs/overlays/emuiibo/favorites.txt" "$dist_dir/ASAP/emuiibo/overlay"
cp_file "$src_dir/programs/homebrews/JKSV/webdav.json" "$dist_dir/ASAP/JKSV"
cp_folder "$src_dir/programs/sysmodules/SaltySD/SaltySD" "$dist_dir/ASAP/SaltySD"
cp_file "$src_dir/ASAP-Updater/ASAP-Updater.nro" "$dist_dir/ASAP"
# cp_file "$src_dir/programs/sys-clk/sys-clk/dist/config/sys-clk/config.ini" "$dist_dir/ASAP"
cp_file "$src_dir/programs/sys-clk/sys-clk-oc/config/sys-clk/config.ini" "$dist_dir/ASAP"

# Bootloader folder copies
cp_folder "$src_dir/Atmosphere/out/nintendo_nx_arm64_armv8a/release/atmosphere-out/bootloader" "$dist_dir/bootloader"
cp_folder "$src_dir/ATLAS/output/bootloader" "$dist_dir/bootloader"
cp_folder "$src_dir/hekate/CTCaer" "$dist_dir/bootloader"
cp_file "$src_dir/ASAP-Updater/ATLAS/output/ATLAS.bin" "$dist_dir/bootloader/payloads"
cp_file "$src_dir/hekate/output/libsys_lp0.bso" "$dist_dir/bootloader/sys"
cp_file "$src_dir/hekate/output/libsys_minerva.bso" "$dist_dir/bootloader/sys"
cp_file "$src_dir/hekate/output/nyx.bin" "$dist_dir/bootloader/sys"

# Create bootloader/ini folder
mkdir -p "$dist_dir/bootloader/ini"

# NSP folder copy
cp_folder "$src_dir/SAK/output/nsp" "$dist_dir/nsp"

# Switch folder copies
cp_folder "$src_dir/Atmosphere/out/nintendo_nx_arm64_armv8a/release/atmosphere-out/switch" "$dist_dir/switch"
cp_file "$src_dir/programs/overlays/emuiibo/overlay/emuiibo.ovl" "$dist_dir/switch/.overlays/.offload"
cp_file "$src_dir/programs/overlays/FPSLocker/FPSLocker.ovl" "$dist_dir/switch/.overlays"
cp_file "$src_dir/programs/overlays/EdiZon-Overlay/out/ovlEdiZon.ovl" "$dist_dir/switch/.overlays"
cp_file "$src_dir/programs/overlays/Ultrahand-Overlay/ovlmenu.ovl" "$dist_dir/switch/.overlays"
cp_file "$src_dir/programs/overlays/ovl-sysmodules/ovlSysmodules.ovl" "$dist_dir/switch/.overlays"
cp_file "$src_dir/programs/overlays/ReverseNX-RT/Out/switch/.overlays/ReverseNX-RT-ovl.ovl" "$dist_dir/switch/.overlays"
cp_file "$src_dir/programs/overlays/Status-Monitor-Overlay/Status-Monitor-Overlay.ovl" "$dist_dir/switch/.overlays"
cp_file "$src_dir/ASAP-Updater/.ASAP-Updater.nro.star" "$dist_dir/switch/ASAP-Updater"
cp_file "$src_dir/programs/homebrews/DBI/.DBI.nro.star" "$dist_dir/switch/DBI"
cp_folder "$src_dir/programs/homebrews/DBI" "$dist_dir/switch/DBI"
cp_folder "$src_dir/programs/homebrews/Tinfoil" "$dist_dir/switch/Tinfoil"

# warmboot_mariko folder copy
cp_folder "$src_dir/Atmosphere/out/nintendo_nx_arm64_armv8a/release/atmosphere-out/warmboot_mariko" "$dist_dir/warmboot_mariko"

# SX_Gear files
cp_folder "$src_dir/misc/modchip/SX/SX_Gear" "$dist_dir"

# Payload file
cp_file "$src_dir/hekate/CTCaer/hekate.bin" "$dist_dir"

# Rename files
[ -f "$dist_dir/ASAP/atmosphere/contents/010B6ECF3B30D000/03/version" ] && mv "$dist_dir/ASAP/atmosphere/contents/010B6ECF3B30D000/03/version" "$dist_dir/ASAP/atmosphere/contents/010B6ECF3B30D000/03/0100B0E8EB470000"
[ -f "$dist_dir/bootloader/hekate.bin" ] && mv "$dist_dir/bootloader/hekate.bin" "$dist_dir/bootloader/update.bin"
[ -f "$dist_dir/hekate.bin" ] && mv "$dist_dir/hekate.bin" "$dist_dir/payload.bin"

# Create locations.conf file
echo '["usb:/","usbfs:/","sdmc:/","sdmc:/roms/","system:/","user:/","safe:/",{"url":"https://tiny.cc/eeveesaveproject","title":"Eevee Save Project","enabled":1},{"url":"https://liberashop.rs/roms","title":"LiberaShop Retro ROMs","enabled":1},{"url":"https://liberashop.rs/","title":"LiberaShop","enabled":1},{"url":"https://publictest:publicpass@switch.ghostland.at/","title":"Ghost eShop","enabled":1}]' > "$dist_dir/ASAP/locations.conf"

# Print completion message
echo "ASAP package created successfully at: $src_dir/output/"