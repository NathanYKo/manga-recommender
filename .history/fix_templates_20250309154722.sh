#!/bin/bash
# Script to fix template escaping issues in Jinja2 templates

# Function to fix a file
fix_file() {
    local file="$1"
    echo "Fixing file: $file"
    # Replace the problematic escaping in the onerror attribute
    sed -i "s/url_for(\\\\'static\\\\', filename=\\\\'img\\/no-cover.jpg\\\\'/url_for('static', filename='img\\/no-cover.jpg'/g" "$file"
}

# Fix template files
echo "Fixing template files..."
find templates -name "*.html" -type f | while read -r file; do
    fix_file "$file"
done

# Fix any history template files if needed
if [ -d ".history" ]; then
    echo "Fixing history template files..."
    find .history -name "*.html" -type f | while read -r file; do
        fix_file "$file"
    done
fi

echo "Fixing completed!" 