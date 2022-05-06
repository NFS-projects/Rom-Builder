# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Awaken/android_manifest -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS-projects/local_manifest --depth 1 -b 12.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export NFS_BUILD_ROM_NAME=${rom_name} # this is for NFSDev™ only
source build/envsetup.sh
export TZ=Asia/Jakarta
export USE_NFSparts=true # this is for NFSDev™ only
export NFS_BUILD_VARIANT=normal # this is for NFSDev™ only normal or overclock
# export NFS_BUILD_TYPE_GAPPS=coregapps # this is for NFSDev™ only
# export TARGET_BUILD_GRAPHENEOS_CAMERA=true
export NFS_ADD_GCAMGO=true
# export WITH_GMS=true
lunch awaken_rosy-user
lunch awaken_rosy-userdebug
curl -s -X POST "https://api.telegram.org/bot${tg_token}/sendMessage" -d chat_id="${tg_id}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="===================================%0A<b>Redmi 5 ($device)</b> Building Rom Started%0A<b>ROM:</b>$rom_name%0A<b>Build Type:</b>$NFS_BUILD_VARIANT%0A$(echo "${var_cache_report_config}")"
make bacon
# end

