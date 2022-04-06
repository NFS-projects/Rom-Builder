# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DotOS/android_manifest -b dot12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b dot_maple_dsds .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export TZ=Asia/Jakarta
export BUILD_USERNAME=znxt
export BUILD_HOSTNAME=znxt
lunch dot_maple_dsds-user
 
curl -s -X POST "https://api.telegram.org/bot${tg_token}/sendMessage" -d chat_id="${tg_id}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="===================================%0A<b>${device_model}</b> Building Rom Started%0A<b>ROM:</b>$rom_name%0A$(echo "${var_cache_report_config}")"

make bacon
 
# end
