#!/bin/sh
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin
DATE=`date +%m-%d-%Y`
# TO DO: Create folder by date and upload to specific folder

# downstairs
#echo 'hello world 0' >> /Users/apple/Desktop/Scripts/Camera/hello.log

for i in /Users/apple/Desktop/camera/downstairs/*.mp4
 do 
 	ffmpeg -i "$i" "${i%.*}.bak.mp4" && rm -f "$i" 
 	mv /Users/apple/Desktop/camera/downstairs/*.bak.mp4 /Users/apple/Desktop/camera/compressed/downstairs/
	aws s3 sync /Users/apple/Desktop/camera/compressed/downstairs/ s3://rtl-cameras/downstairs/$DATE --profile cams >> /Users/apple/Desktop/Scripts/Camera/s3camupload-downstairs.log && rm -f /Users/apple/Desktop/camera/compressed/downstairs/*;
	done 

# frontdoor
for i in /Users/apple/Desktop/camera/frontdoor/*.mp4
 do 
 	ffmpeg -i "$i" "${i%.*}.bak.mp4" && rm -f "$i" 
 	mv /Users/apple/Desktop/camera/frontdoor/*.bak.mp4 /Users/apple/Desktop/camera/compressed/frontdoor/
	aws s3 sync /Users/apple/Desktop/camera/compressed/frontdoor/ s3://rtl-cameras/frontdoor/$DATE --profile cams >> /Users/apple/Desktop/Scripts/Camera/s3camupload-frontdoor.log && rm -f /Users/apple/Desktop/camera/compressed/frontdoor/*;
	done 