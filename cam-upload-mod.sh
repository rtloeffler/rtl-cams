#!/bin/sh
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin
DATE=`date +%m-%d-%Y`

adddate() {
    while IFS= read -r line; do
        echo "$(date) $line"
    done
}


# downstairs
for i in /Users/apple/Desktop/camera/downstairs/*.mp4
 do 
 	ffmpeg -i "$i" -vcodec libx264 -crf 24 -s 720x480 "${i%.*}.bak.mp4" && rm -f "$i"
 	mv /Users/apple/Desktop/camera/downstairs/*.bak.mp4 /Users/apple/Desktop/camera/compressed/downstairs/	
	done 

# frontdoor
for i in /Users/apple/Desktop/camera/frontdoor/*.mp4
 do 
 	ffmpeg -i "$i" -vcodec libx264 -crf 24 -s 720x480 "${i%.*}.bak.mp4" && rm -f "$i"
 	mv /Users/apple/Desktop/camera/frontdoor/*.bak.mp4 /Users/apple/Desktop/camera/compressed/frontdoor/	
	done 



	aws s3 sync /Users/apple/Desktop/camera/compressed/downstairs/ s3://rtl-cameras/downstairs/$DATE --profile cams --sse AES256 --storage-class STANDARD_IA | adddate >> /Users/apple/Git/rtl-cams/s3camupload-downstairs.log && rm -f /Users/apple/Desktop/camera/compressed/downstairs/*;
	aws s3 sync /Users/apple/Desktop/camera/compressed/frontdoor/ s3://rtl-cameras/frontdoor/$DATE --profile cams --sse AES256 --storage-class STANDARD_IA | adddate >> /Users/apple/Git/rtl-cams/s3camupload-frontdoor.log && rm -f /Users/apple/Desktop/camera/compressed/frontdoor/*;