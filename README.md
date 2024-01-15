# ffmpeg-filename-autochapter

This script creates FFmpeg [chapters data file](https://ffmpeg.org/ffmpeg-formats.html#Metadata-1).


### How to use

Run this script inside directory with media files:

```
./autochapter.sh
```

It will generate something like this:

```
;FFMETADATA1
[CHAPTER]
TIMEBASE=1/1
START=0
END=3560
title=01_Chapter One


[CHAPTER]
TIMEBASE=1/1
START=3560
END=5803
title=02_Chapter Two
```

Then concat files and write chapters:

```
ffmpeg -safe 0 -f concat -i <(for f in *.ogg; do echo "file '$PWD/$f'"; done) -c copy output.ogg
ffmpeg -i output.ogg -i FFMETADATAFILE -map_metadata 1 -codec copy output2.ogg
```
