#!/bin/bash

# Top drectory path
TOP_DIR=$(dirname "$(readlink -f "$0")")

cd "$TOP_DIR"

# Writing Log
print_header() {
    local header=$1
    local file=$2
    local line_len=100
    local header_len=${#header}
    local padding=$(( (line_len - header_len) / 2 ))
    local pad=$(printf '%*s' $padding '')
    local line=$(printf '%*s' $line_len '')

    echo "${line// /-}" | tee -a "$file"
    echo "${pad// / }$header" | tee -a "$file"
    echo "${line// /-}" | tee -a "$file"
}

# Build project
ASAP_project() {
    local project=$1
    local build_command=$2
    local parallel=$3
    local log_file="$TOP_DIR/build.log"

    clean_up "$project"
    print_header "Building $project..." "$log_file"
    
    echo "Building $project at $(date)" | tee -a "$log_file"
    cd "$project"
    if [ "$parallel" = "y" ]; then
        $build_command -j$(nproc) | tee -a "$log_file"
    else
        $build_command | tee -a "$log_file"
    fi
    cd "$TOP_DIR"
}

# Cleanup project dir
clean_up() {
    local project_dir=$1
    echo "Cleaning up in $project_dir..."
    cd "$project_dir"
    if [ "$(basename "$project_dir")" != "sys-con" ]; then
        rm -rf build dist output out
    else
        rm -rf build output out
    fi
    find . -maxdepth 1 -type f \( -name '*.elf' -o -name '*.nacp' -o -name '*.nro' -o -name '*.nso' -o -name '*.nsp' -o -name '*.ovl' -o -name '*.pfs0' \) -delete
    cd "$TOP_DIR"
}

# ASAP project
ASAP_project libnx "make install" "y"
ASAP_project Atmosphere "make" "y"
ASAP_project hekate "make" "y"
ASAP_project ASAP-Updater "make" "n"
ASAP_project ATLAS "make" "n"
ASAP_project hb/hbmenu "make" "y"
ASAP_project hb/nx-hbloader "make" "y"
ASAP_project programs/patches/sys-patch "make" "y"
ASAP_project programs/patches/SPU "make" "y"
ASAP_project programs/homebrews/JKSV "make" "y"
ASAP_project programs/homebrews/Linkalho "make" "y"
ASAP_project programs/overlays/EdiZon-Overlay "make" "y"
ASAP_project programs/overlays/emuiibo "make" "y"
ASAP_project programs/overlays/FPSLocker "make" "y"
ASAP_project programs/overlays/ovl-sysmodules "make" "y"
ASAP_project programs/overlays/ReverseNX-RT "make" "y"
ASAP_project programs/overlays/Status-Monitor-Overlay "make" "y"
# ASAP_project programs/sys-clk/sys-clk "make" "y"
ASAP_project programs/overlays/Ultrahand-Overlay "make" "y"
ASAP_project programs/sysmodules/sys-con "make" "n"
ASAP_project programs/sysmodules/MissionControl "make dist" "n"

echo "ASAP build Completed" | tee -a "$TOP_DIR/build.log"
sleep 3
exit