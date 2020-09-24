#!/bin/bash

REPOSITORY_NAME=$(basename $(realpath .))

function add_headers {
    dir="$1"
    parent="$2"

    for file in $dir/*.md; do
        if [ -f "$file" ]; then
            if ! grep -q "layout:" "$file"; then
                echo "---" >> "$file.new"
                echo "layout: default" >> "$file.new"
                echo "parent: $parent" >> "$file.new"
                echo "---" >> "$file.new"
                echo "" >> "$file.new"

                cat "$file" >> "$file.new"
                \mv "$file.new" "$file"
            fi
        fi
    done
}

function create_schematics_page {
    dir="$1"
    subdir="schematics"
    md_file="$dir/$subdir/index.md"

    # Clean
    \rm -rf "$md_file"

    # Add title
    echo "# Schematics" >> "$md_file"
    echo "" >> "$md_file"

    # Add pdf link
    echo "  - [.pdf Download]($(basename $dir/$subdir/*-Schematic.pdf))" >> "$md_file"
    
    # Add images
    for file in $dir/$subdir/*.svg; do
        if [ -f "$file" ]; then
            file=$(basename "$file")
            filename="${file%.*}"
            echo "## $filename" >> "$md_file"
            url="$file"
            echo "<a href=\"$url\"><img src=\"$url\"></a>" >> "$md_file"
            echo "" >> "$md_file"
        fi
    done
}

function create_layout_page {
    dir="$1"
    subdir="layout"
    md_file="$dir/$subdir/index.md"

    # Clean
    \rm -rf "$md_file"

    # Add title
    echo "# Layout" >> "$md_file"
    echo "" >> "$md_file"
    
    # Add images
    for file in $dir/$subdir/*.svg; do
        if [ -f "$file" ]; then
            file=$(basename "$file")
            filename="${file%.*}"
            echo "## $filename" >> "$md_file"
            url="$file"
            echo "<a href=\"$url\"><img src=\"$url\"></a>" >> "$md_file"
            echo "" >> $md_file
        fi
    done
}

function create_gerbers_page {
    dir="$1"
    subdir="gerbers"
    md_file="$dir/$subdir/index.md"

    # Clean
    \rm -rf "$md_file"

    # Add title
    echo "# Gerbers" >> "$md_file"
    echo "" >> "$md_file"

    # Add zip link
    echo "  - [.zip Download]($(basename $dir/$subdir/*-Gerbeers.zip))" >> "$md_file"
    
    # Add gerbers links
    for file in $dir/$subdir/*.{gbr,csv,txt,job,drl}; do
        if [ -f "$file" ]; then
            file=$(basename "$file")
            url="$file"
            echo "  - [$file]($url)" >> "$md_file"
            echo "" >> "$md_file"
        fi
    done
}

function create_bom_page {
    dir="$1"
    subdir="bom"
    md_file="$dir/$subdir/index.md"

    # Clean
    \rm -rf "$md_file"

    # Add title
    echo "# BOM" >> "$md_file"
    echo "" >> "$md_file"

    # Add links
    echo "  - [**Interactive BOM**]($REPOSITORY_NAME-interactive-bom.html)" >> "$md_file"
    echo "  - [BOM]($REPOSITORY_NAME-bom.html)" >> "$md_file"
    echo "  - [.csv Download]($REPOSITORY_NAME-bom.csv)" >> "$md_file"
    echo "  - [.xlsx Download]($REPOSITORY_NAME-bom.xlsx)" >> "$md_file"
}

function create_cad_page {
    dir="$1"
    subdir="cad"
    md_file="$dir/$subdir/index.md"

    # Clean
    \rm -rf "$md_file"

    # Add title
    echo "# 3D Model" >> "$md_file"
    echo "" >> "$md_file"

    # Add model links
    for file in $dir/$subdir/*.{stl,step}; do
        if [ -f "$file" ]; then
            file=$(basename "$file")
            url="$file"
            echo "  - [$file]($url)" >> "$md_file"
            echo "" >> "$md_file"
        fi
    done
}

# Create each page
create_schematics_page "hardware"
create_layout_page "hardware"
create_gerbers_page "hardware"
create_bom_page "hardware"
create_cad_page "hardware"

# Add jekyll header to all pages
add_headers "firmware" "Firmware"
add_headers "hardware/*/" "Hardware"

# Replace repository name in all files
sed -i "s/@REPOSITORY_NAME@/$REPOSITORY_NAME/g" $(find . -type f -print0 | xargs -0 grep -l "@REPOSITORY_NAME@")
