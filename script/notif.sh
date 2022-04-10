#!/usr/bin/env bash

export my_dir="$HOME"
export device="$(grep unch $my_dir/script/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)"
export rom_name="$(grep init $my_dir/script/build_rom.sh -m 1 | cut -d / -f 4)"
export branch_name=$(grep init $my_dir/script/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
cd $my_dir/$rom_name/out/target/product/$device
export rel_date="$(date "+%Y%m%d")"
export file_name="$(echo *${rel_date}*.zip)"
telegram_message() {
         curl -s -X POST "https://api.telegram.org/bot${tg_token}/sendMessage" \
         -d chat_id="${tg_id}" \
         -d parse_mode="HTML" \
         -d text="$1"
}
DL_LINK="https://rombuilder.projek.workers.dev/$rom_name/$device/$file_name"
echo "=============================================="
echo "Download Link: ${DL_LINK}" || { echo "ERROR: Failed to Upload the Build!"; }
echo "=============================================="
DATE_L="$(date +%d\ %B\ %Y)"
DATE_S="$(date +"%T")"
echo -e \
"
🚀 ${rom_name}

✅ Build Completed Successfully!

📱 Device: "${device_model}"
🖥 Branch Build: "${branch_name}"
⬇️ Download Link: <a href=\"${DL_LINK}\">Here</a>
📅 Date: "$(date +%d\ %B\ %Y)"
⏱ Time: "$(date +%T)"
" > tg.html
TG_TEXT=$(< tg.html)
telegram_message "$TG_TEXT"
echo " "
rm -rf $my_dir/$rom_name/out/target/product/$device
cd $my_dir
rm -rf .repo*
