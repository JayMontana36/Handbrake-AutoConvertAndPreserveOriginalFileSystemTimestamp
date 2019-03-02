#!/bin/sh
#
HOME=/data/mediaserver/Handbrake
TOUCH=touch
SRC=$HOME/RAW
DEST=$HOME/Post
DEST_EXT=mkv
HANDBRAKE_CLI=HandBrakeCLI
PRESET="H.265 MKV 1080p30"
IFS=$(echo -en "\n\b")
#
if [ -f "$HOME/Handbrake.running" ]; then
        exit
fi
#
$TOUCH $HOME/Handbrake.running
#
for FILE in `ls $SRC`
do
        filename=$(basename $FILE)
        extension=${filename##*.}
        filename=${filename%.*}
#
        $HANDBRAKE_CLI --all-audio --all-subtitles -i "$SRC/$FILE" -o "$DEST/$filename.$DEST_EXT" --preset="$PRESET"
        if [ -f "$DEST/$filename.$DEST_EXT" ]; then
                $TOUCH -r "$SRC/$FILE" "$DEST/$filename.$DEST_EXT"
                #mv "$SRC/$FILE" "$DEST/RAW/$FILE"
                #rm -rf "$SRC/$FILE"
                fi
done
#
rm -rf $HOME/Handbrake.running
