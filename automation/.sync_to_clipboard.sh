#!/bin/bash

# Path updated according to server logs
WATCH_DIR="/home/nikita/Nextcloud/InstantUpload/Learning_Photos"

echo "🚀 Listening for photos in: $WATCH_DIR"

# Ensure the directory exists to prevent script failure
mkdir -p "$WATCH_DIR"

# Monitor the directory for new files moved into it
inotifywait -m -e moved_to --format '%f' "$WATCH_DIR" | while read FILE
do
    # Check if the file is a supported image format
    if [[ "$FILE" =~ \.(jpg|jpeg|png|JPG|PNG)$ ]]; then

        # Ignore hidden/temporary files
        if [[ "$FILE" == .* ]]; then
            continue
        fi

        FULL_PATH="$WATCH_DIR/$FILE"

        # Brief delay to ensure file synchronization is complete
        sleep 1

        if [ -f "$FULL_PATH" ]; then
            echo "📸 New photo detected: $FILE"

            # Identify MIME type and copy to Wayland clipboard
            MIME_TYPE=$(file --mime-type -b "$FULL_PATH")
            wl-copy --type "$MIME_TYPE" < "$FULL_PATH"

            # Send desktop notification in Arch
            notify-send "Nextcloud Sync" "Image copied! Ready to paste (Ctrl+V)" --icon=image-photo

            echo "✅ Ready to paste!"
        fi
    fi
done