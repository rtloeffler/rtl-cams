#!/bin/sh
process=`ps -ef | grep -v grep | grep cam-upload-mod.sh`

if ps -ef | grep -v grep | grep cam-upload-mod.sh; then
#        echo 'process running' >> /Users/apple/Desktop/Scripts/Camera/cam-checker-fail.log
#        echo $process >> /Users/apple/Desktop/Scripts/Camera/cam-checker-fail.log
        exit 0
else
#		echo "im about to run" >> /Users/apple/Desktop/Scripts/Camera/cam-checker-success.log
        /Users/apple/Desktop/Scripts/Camera/cam-upload-mod.sh
        exit 0
fi