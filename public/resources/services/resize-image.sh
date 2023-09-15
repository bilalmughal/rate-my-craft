#!/bin/bash

# Directory containing the images
DIR="images"

# Ensure thumbs directory exists
THUMBS_DIR="./thumbs"
mkdir -p "$THUMBS_DIR"

# Process each image in the directory
for img in "$DIR"/*.{jpg,png,jpeg}; do
    # Extract the image filename from its full path
    filename=$(basename "$img")
    base="${filename%.*}"
    ext="${filename##*.}"

    # Standard version
    convert "$img" -resize "374x250^" -gravity center -extent 374x250 "$THUMBS_DIR/$filename"

    # Retina version
    convert "$img" -resize "748x500^" -gravity center -extent 748x500 "$THUMBS_DIR/${base}@2x.$ext"
done
