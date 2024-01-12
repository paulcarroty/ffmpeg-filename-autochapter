#!/bin/sh
START=0
END=0
! test -f FFMETADATAFILE && touch FFMETADATAFILE
echo ';FFMETADATA1' > FFMETADATAFILE


for FILE in *.{mp3,m4a,ogg,aac,opus,mp4,mkv,avi,webm};
    do
    [ -e "$FILE" ] || continue
    DURATION="$(ffprobe -v quiet -print_format compact=print_section=0:nokey=1:escape=csv -show_entries format=duration "$FILE")";
    DURATION="$(echo $DURATION | xargs printf %.0f)"
    FILENAME="${FILE%%.*}"
    END=$[$END + $DURATION];
    START=$[$END - $DURATION];
    
    echo [CHAPTER]          >> FFMETADATAFILE
    echo TIMEBASE=1/1       >> FFMETADATAFILE
    echo START="$START"     >> FFMETADATAFILE
    echo END="$END"         >> FFMETADATAFILE
    echo title="$FILENAME"  >> FFMETADATAFILE
    echo -e "\n"            >> FFMETADATAFILE

done
