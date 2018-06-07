#!/sbin/sh
#
# /system/addon.d/90-emoji.sh
# During a system upgrade, this script backs up the current emoji font,
# /system is formatted and reinstalled, then the file is restored.
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
fonts/NotoColorEmoji.ttf
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Backup original font
    copy_file $S/fonts/NotoColorEmoji.ttf $S/fonts/NotoColorEmoji.ttf.old
  ;;
  post-restore)
    # Stub
  ;;
esac

