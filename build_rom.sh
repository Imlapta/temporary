# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ProjectBlaze/manifest.git -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/OmarAlCoptan/local_manifest.git --depth 1 -b blaze-test .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
   
# build rom
source build/envsetup.sh
lunch blaze_lavender-userdebug
export WITH_GAPPS=true
export TZ=Africa/Egypt #put before last build command
brunch lavender        
 
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

